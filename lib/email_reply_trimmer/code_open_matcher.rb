# frozen_string_literal: true

=begin
Code blocks must begin with three tick marks (```) on a line
  Those tick marks may not have any characters before them
  Openening tick marks may have text after them
Code blocks must end with three tick marks (```) on a line
  Those tick marks may have no more than three spaces before them
  Those tick marks may only have white space after them
=end

class CodeOpenMatcher

  DELIMITER_REGEX      ||= /^```/

  def self.match?(line)
    line =~ DELIMITER_REGEX
  end

end
