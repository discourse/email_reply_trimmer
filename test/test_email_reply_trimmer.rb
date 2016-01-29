require "minitest/autorun"
require "email_reply_trimmer"

class TestEmailReplyTrimmer < Minitest::Test

  EMAILS  = Dir["test/emails/*.txt"].map  { |path| File.basename(path) }
  REPLIES = Dir["test/replies/*.txt"].map { |path| File.basename(path) }

  def test_all_emails_have_a_matching_reply
    assert_equal EMAILS, REPLIES, "Files in /emails and /replies folders should match 1-to-1"
  end

  def test_normalize_line_endings_email_has_windows_line_endings
    assert_match /\r\n/, File.read("test/emails/normalize_line_endings.txt")
  end

  EMAILS.each do |filename|
    name = File.basename(filename, ".txt")
    define_method("test_#{name}") do
      assert_equal trim(filename), reply(filename), "EMAIL: #{filename}"
    end
  end

  def trim(filename)
    body = File.read("test/emails/#{filename}")
    EmailReplyTrimmer.trim(body)
  end

  def reply(filename)
    File.read("test/replies/#{filename}").strip
  end

end
