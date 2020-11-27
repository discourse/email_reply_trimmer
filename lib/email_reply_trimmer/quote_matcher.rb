# frozen_string_literal: true
class QuoteMatcher

  def self.match?(line)
    line =~ /^[[:blank:]]*>/
  end

end
