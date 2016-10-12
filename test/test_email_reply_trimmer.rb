require "minitest/autorun"
require "email_reply_trimmer"

class TestEmailReplyTrimmer < Minitest::Test

  EMAILS  = Dir["test/emails/*.txt"].map  { |path| File.basename(path) }
  TRIMMED = Dir["test/trimmed/*.txt"].map { |path| File.basename(path) }
  ELIDED  = Dir["test/elided/*.txt"].map { |path| File.basename(path) }

  def test_all_emails_have_a_matching_reply
    assert_equal(EMAILS, TRIMMED, "Files in /emails and /trimmed folders should match 1-to-1.")
    assert_equal(EMAILS, ELIDED, "Files in /emails and /elided folders should match 1-to-1.")
  end

  def test_normalize_line_endings_email_has_windows_line_endings
    assert_match(/\r\n/, File.read("test/emails/normalize_line_endings.txt"))
  end

  EMAILS.each do |filename|
    name = File.basename(filename, ".txt")
    define_method("test_#{name}") do
      assert_equal(trim(filename), trimmed(filename), "[TRIMMED] EMAIL: #{filename}")
      assert_equal(elide(filename), elided(filename), "[ELIDED] EMAIL: #{filename}")
    end
  end

  def trim(filename)
    EmailReplyTrimmer.trim(email(filename))
  end

  def elide(filename)
    EmailReplyTrimmer.trim(email(filename), true)[1]
  end

  def email(filename)
    File.read("test/emails/#{filename}").strip
  end

  def trimmed(filename)
    File.read("test/trimmed/#{filename}").strip
  end

  def elided(filename)
    File.read("test/elided/#{filename}").strip
  end

end
