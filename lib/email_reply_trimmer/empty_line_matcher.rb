# frozen_string_literal: true
class EmptyLineMatcher

  def self.match?(line)
    line =~ /^[[:blank:]]*$/
  end

end
