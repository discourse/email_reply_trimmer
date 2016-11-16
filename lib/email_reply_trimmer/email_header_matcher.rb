class EmailHeaderMatcher

  EMAIL_HEADERS_WITH_DATE_MARKERS = [
    # Dutch
    ["Sendt"],
    # English
    ["Sent"],
    # French
    ["Date"],
    # German
    ["Gesendet"],
    # Portuguese
    ["Enviada em"],
    # Spanish
    ["Enviado"],
    # Spanish (Mexican)
    ["Fecha"],
    # Italian
    ["Data"],
  ]

  EMAIL_HEADERS_WITH_DATE_REGEXES = EMAIL_HEADERS_WITH_DATE_MARKERS.map do |header|
    /^[[:blank:]>\*]*(?:#{header.join("|")})[[:blank:]\*]*:.*\d+/
  end

  EMAIL_HEADERS_WITH_TEXT_MARKERS = [
    # Dutch
    ["Fra", "Til", "Emne"],
    # English
    ["From", "To", "Cc", "Reply-To", "Subject"],
    # French
    ["De", "À", "Répondre à", "Objet"],
    # German
    ["Von", "An", "Betreff"],
    # Portuguese
    ["De", "Para", "Assunto"],
    # Spanish
    ["De", "Para", "Asunto"],
    # Italian
    ["Da", "Risposta", "A", "Oggetto"]
  ]

  EMAIL_HEADERS_WITH_TEXT_REGEXES = EMAIL_HEADERS_WITH_TEXT_MARKERS.map do |header|
    /^[[:blank:]>\*]*(?:#{header.join("|")})[[:blank:]\*]*:.*[[:word:]]+/
  end

  EMAIL_HEADER_REGEXES = [
    EMAIL_HEADERS_WITH_DATE_REGEXES,
    EMAIL_HEADERS_WITH_TEXT_REGEXES,
  ].flatten

  def self.match?(line)
    EMAIL_HEADER_REGEXES.any? { |r| line =~ r }
  end

end
