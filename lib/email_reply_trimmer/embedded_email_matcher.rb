class EmbeddedEmailMatcher

  # On Wed, Sep 25, 2013, at 03:57 PM, jorge_castro wrote:
  # On Thursday, June 27, 2013, knwang via Discourse Meta wrote:
  # On Wed, 2015-12-02 at 13:58 +0000, Tom Newsom wrote:
  # On 10/12/15 12:30, Jeff Atwood wrote:
  # ---- On Tue, 22 Dec 2015 14:17:36 +0530 Sam Saffron&lt;info@discourse.org&gt; wrote ----
  # Op 24 aug. 2013 om 16:48 heeft ven88 via Discourse Meta <info@discourse.org> het volgende geschreven:
  # Le 4 janv. 2016 19:03, "Neil Lalonde" <info@discourse.org> a écrit :
  # Dnia 14 lip 2015 o godz. 00:25 Michael Downey <info@discourse.org> napisał(a):
  # Em seg, 27 de jul de 2015 17:13, Neil Lalonde <info@discourse.org> escreveu:
  # El jueves, 21 de noviembre de 2013, codinghorror escribió:
  # Am 03.02.2016 3:35 nachm. schrieb Max Mustermann <mail@example.com>:
  ON_DATE_SOMEONE_WROTE_MARKERS = [
    # Dutch
    ["Op","het volgende geschreven"],
    # English
    ["On", "wrote"],
    # French
    ["Le", "a écrit "],
    # Italian
    ["Il", "ha scritto"],
    # Polish
    ["Dnia", "napisał\\(a\\)"],
    # Portuguese
    ["Em", "escreveu"],
    # Spanish
    ["El", "escribió"],
    # German
    ["Am", "schrieb"],
  ]

  ON_DATE_SOMEONE_WROTE_REGEXES = ON_DATE_SOMEONE_WROTE_MARKERS.map do |on, wrote|
    wrote.gsub!(/ +/, "[[:space:]]+") # the "wrote" part might span over multiple lines
    /^([[:blank:]>\-]*#{on}\s(?:(?!#{on}\s|#{wrote}:?)[\s\S])*#{wrote}:?[[:blank:]\-]*)$/m
  end

  # Op 10 dec. 2015 18:35 schreef "Arpit Jalan" <info@discourse.org>:
  # Am 18.09.2013 um 16:24 schrieb codinghorror <info@discourse.org>:
  ON_DATE_WROTE_SOMEONE_MARKERS = [
    # Dutch
    ["Op", "schreef"],
    # German
    ["Am", "schrieb"],
  ]

  ON_DATE_WROTE_SOMEONE_REGEXES = ON_DATE_WROTE_SOMEONE_MARKERS.map do |on, wrote|
    /^[[:blank:]>]*#{on}\s.+\s#{wrote}\s[^:]+:/
  end

  # суббота, 14 марта 2015 г. пользователь etewiah написал:
  DATE_SOMEONE_WROTE_MARKERS = [
    # Russian
    ["пользователь", "написал"],
  ]

  DATE_SOMEONE_WROTE_REGEXES = DATE_SOMEONE_WROTE_MARKERS.map do |user, wrote|
    /.+#{user}.+#{wrote}:/
  end

  # 2016-03-03 17:21 GMT+01:00 Some One
  ISO_DATE_SOMEONE_REGEX = /^[[:blank:]>]*20\d\d-\d\d-\d\d \d\d:\d\d GMT\+\d\d:\d\d [\w[:blank:]]+$/

  # 2015-10-18 0:17 GMT+03:00 Matt Palmer <info@discourse.org>:
  # 2013/10/2 camilohollanda <info@discourse.org>
  # вт, 5 янв. 2016 г. в 23:39, Erlend Sogge Heggen <info@discourse.org>:
  # ср, 1 апр. 2015, 18:29, Denis Didkovsky <info@discourse.org>:
  DATE_SOMEONE_EMAIL_REGEX = /^[[:blank:]>]*.*\d{4}.+<[^@<>]+@[^@<>.]+\.[^@<>]+>:?$/

  # codinghorror via Discourse Meta wrote:
  # codinghorror via Discourse Meta <info@discourse.org> schrieb:
  SOMEONE_VIA_SOMETHING_WROTE_MARKERS = [
    # English
    "wrote",
    # German
    "schrieb",
  ]

  SOMEONE_VIA_SOMETHING_WROTE_REGEXES = SOMEONE_VIA_SOMETHING_WROTE_MARKERS.map do |wrote|
    /^[[:blank:]>]*.+ via .+ #{wrote}:?[[:blank:]]*$/
  end

  # Some One <info@discourse.org> wrote:
  SOMEONE_EMAIL_WROTE_REGEX = /^[[:blank:]>]*.+ <.+@.+\..+> wrote:?/

  # Posted by mpalmer on 01/21/2016
  POSTED_BY_SOMEONE_ON_DATE_REGEX = /^[[:blank:]>]*Posted by .+ on \d{2}\/\d{2}\/\d{4}$/i

  # Begin forwarded message:
  # Reply Message
  # ----- Forwarded Message -----
  # ----- Original Message -----
  # -----Original Message-----
  # *----- Original Message -----*
  FORWARDED_EMAIL_REGEXES = [
    # English
    /^[[:blank:]>]*Begin forwarded message:/i,
    /^[[:blank:]>]*Reply message/i,
    /^[[:blank:]>\*]*-{2,}[[:blank:]]*(Forwarded|Original) Message[[:blank:]]*-{2,}/i,
    # French
    /^[[:blank:]>\*]*-{2,}[[:blank:]]*Message transféré[[:blank:]]*-{2,}/i,
    # German
    /^[[:blank:]>\*]*-{2,}[[:blank:]]*Ursprüngliche Nachricht[[:blank:]]*-{2,}/i,
    # Spanish
    /^[[:blank:]>\*]*-{2,}[[:blank:]]*Mensaje original[[:blank:]]*-{2,}/i,
  ]

  EMBEDDED_REGEXES = [
    ON_DATE_SOMEONE_WROTE_REGEXES,
    ON_DATE_WROTE_SOMEONE_REGEXES,
    DATE_SOMEONE_WROTE_REGEXES,
    DATE_SOMEONE_EMAIL_REGEX,
    ISO_DATE_SOMEONE_REGEX,
    SOMEONE_VIA_SOMETHING_WROTE_REGEXES,
    SOMEONE_EMAIL_WROTE_REGEX,
    POSTED_BY_SOMEONE_ON_DATE_REGEX,
    FORWARDED_EMAIL_REGEXES,
  ].flatten

  def self.match?(line)
    EMBEDDED_REGEXES.any? { |r| line =~ r }
  end

end
