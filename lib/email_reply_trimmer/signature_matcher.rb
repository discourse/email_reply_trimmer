class SignatureMatcher

  # Envoyé depuis mon iPhone
  # Von meinem Mobilgerät gesendet
  # Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
  # Nik from mobile
  # From My Iphone 6
  # Sent via mobile
  # Sent with Airmail
  # Sent from Windows Mail
  # Sent from my TI-85
  # <<sent by galaxy>>
  # (sent from a phone)
  # (Sent from mobile device)
  # 從我的 iPhone 傳送
  SIGNATURE_REGEXES = [
    # Chinese
    /^[[:blank:]>]*從我的 iPhone 傳送/i,
    # English
    /^[[:blank:]>]*[[:word:]]+ from mobile/i,
    /^[[:blank:]>]*[\(<]*sent (?:from|via|with|by) .+[\)>]*/i,
    /^[[:blank:]>]*from my .{1,20}/i, # don't match too much
    # French
    /^[[:blank:]>]*Envoyé depuis mon .+/i,
    # German
    /^[[:blank:]>]*Von meinem .+ gesendet/i,
    /^[[:blank:]>]*Diese Nachricht wurde von .+ gesendet/i,
    # Spanish
    /^[[:blank:]>]*Enviado desde mi .+/i,
  ]

  def self.match?(line)
    SIGNATURE_REGEXES.any? { |r| line =~ r }
  end

end
