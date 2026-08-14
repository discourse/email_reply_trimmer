# frozen_string_literal: true
class DelimiterMatcher

  DELIMITER_CHARACTERS = "-_,=+~#*ᐧ—"
  DELIMITER_REGEX      = /^[[:blank:]]*[#{Regexp.escape(DELIMITER_CHARACTERS)}]+[[:blank:]]*$/

  # A single "-" or "*" on its own line (ignoring surrounding blanks) is the
  # way many mail clients render a plain-text bullet list item, not a reply
  # or signature separator. Real separators built from these characters use
  # at least two of them ("--", "***", "-----"), so excluding the lone case
  # avoids discarding bullet-list content while leaving genuine separators
  # (and every other delimiter character) untouched.
  BULLET_MARKER_REGEX = /\A[[:blank:]]*[-*][[:blank:]]*\z/

  def self.match?(line)
    return false if BULLET_MARKER_REGEX.match?(line)

    line =~ DELIMITER_REGEX
  end

end
