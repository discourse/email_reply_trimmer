class EmptyLineMatcher

  def self.match?(line)
    line =~ /^[[:space:]]*$/
  end

end
