require_relative "email_reply_trimmer/empty_line_matcher"
require_relative "email_reply_trimmer/delimiter_matcher"
require_relative "email_reply_trimmer/signature_matcher"
require_relative "email_reply_trimmer/embedded_email_matcher"
require_relative "email_reply_trimmer/email_header_matcher"
require_relative "email_reply_trimmer/quote_matcher"

class EmailReplyTrimmer
  VERSION = "0.1.2"

  DELIMITER    = "d"
  EMBEDDED     = "b"
  EMPTY        = "e"
  EMAIL_HEADER = "h"
  QUOTE        = "q"
  SIGNATURE    = "s"
  TEXT         = "t"

  def self.identify_line_content(line)
    return EMPTY        if EmptyLineMatcher.match?(line)
    return DELIMITER    if DelimiterMatcher.match?(line)
    return SIGNATURE    if SignatureMatcher.match?(line)
    return EMBEDDED     if EmbeddedEmailMatcher.match?(line)
    return EMAIL_HEADER if EmailHeaderMatcher.match?(line)
    return QUOTE        if QuoteMatcher.match?(line)
    return TEXT
  end

  def self.trim(text, split=false)
    return "" if text.nil? || text =~ /\A[[:space:]]*\Z/m

    # normalize line endings
    text.gsub!(/\r*\n/, "\n")

    # fix embedded email markers that might span over multiple lines
    EmbeddedEmailMatcher::ON_DATE_SOMEONE_WROTE_REGEXES.each do |r|
      if text =~ r
        text.gsub!(r) { |m| m.gsub(/\n[[:space:]>\-]*/, " ") }
      end
    end

    removed = []

    # from now on, we'll work on a line-by-line basis
    lines = text.split("\n")

    # identify content of each lines
    pattern = lines.map { |l| identify_line_content(l) }.join

    # remove all signatures & delimiters
    while pattern =~ /[ds]/
      index = pattern =~ /[ds]/
      pattern.slice!(index)
      lines.slice!(index)
    end

    # if there is an embedded email marker, not followed by a quote
    # then take everything up to that marker
    if pattern =~ /te*b[^q]*$/
      index = pattern =~ /te*b[^q]*$/
      removed = lines[(index + 1)..-1]
      pattern = pattern[0..index]
      lines = lines[0..index]
    end

    # if there is an embedded email marker, followed by a huge quote
    # then take everything up to that marker
    if pattern =~ /te*b[eqbh]*[te]*$/
      index = pattern =~ /te*b[eqbh]*[te]*$/
      removed = lines[(index + 1)..-1]
      pattern = pattern[0..index]
      lines = lines[0..index]
    end

    # if there still are some embedded email markers, just remove them
    while pattern =~ /b/
      index = pattern =~ /b/
      pattern[index] = "e"
      lines[index] = ""
    end

    # fix email headers when they span over multiple lines
    if pattern =~ /h+[hte]+h+e/
      index = pattern =~ /h+[hte]+h+e/
      size = pattern[/h+[hte]+h+e/].size
      size.times.each { |s| pattern[index + s] = EMAIL_HEADER }
    end

    # if there are at least 3 consecutive email headers, take everything up to
    # these headers
    if pattern =~ /t[eq]*h{3,}/
      index = pattern =~ /t[eq]*h{3,}/
      removed = lines[(index + 1)..-1]
      pattern = pattern[0..index]
      lines = lines[0..index]
    end

    # if there still are some email headers, just remove them
    while pattern =~ /h/
      index = pattern =~ /h/
      pattern.slice!(index)
      lines.slice!(index)
    end

    # remove trailing quotes when there's at least one line of text
    if pattern =~ /t/ && pattern =~ /[eq]+$/
      index = pattern =~ /[eq]+$/
      pattern = pattern[0...index]
      lines = lines[0...index]
    end

    # results
    trimmed = lines.join("\n").strip
    elided = removed.join("\n").strip

    if split
      [trimmed, elided]
    else
      trimmed
    end
  end

end
