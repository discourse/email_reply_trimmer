class QuoteMatcher

  def self.match?(line)
    line =~ /^[[:space:]]*>/
  end

end
