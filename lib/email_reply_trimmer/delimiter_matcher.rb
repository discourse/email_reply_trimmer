class DelimiterMatcher

  DELIMITER_CHARACTERS ||= "-_,=+~#*ᐧ"
  DELIMITER_REGEX      ||= /^[[:blank:]]*[#{Regexp.escape(DELIMITER_CHARACTERS)}]+[[:blank:]]*$/

  def self.match?(line)
    line =~ DELIMITER_REGEX
  end

end
