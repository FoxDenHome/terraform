resource "cloudflare_record" "smtp1" {
  count = var.fastmail ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "@"
  type            = "MX"
  value           = "in1-smtp.messagingengine.com"
  priority        = 10
}

resource "cloudflare_record" "smtp2" {
  count = var.fastmail ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "@"
  type            = "MX"
  value           = "in2-smtp.messagingengine.com"
  priority        = 20
}

resource "cloudflare_record" "dkim1" {
  count = var.fastmail ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "fm1._domainkey"
  type            = "CNAME"
  value           = "fm1.${var.domain}.dkim.fmhosted.com"
  proxied         = false
}

resource "cloudflare_record" "dkim2" {
  count = var.fastmail ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "fm2._domainkey"
  type            = "CNAME"
  value           = "fm2.${var.domain}.dkim.fmhosted.com"
  proxied         = false
}

resource "cloudflare_record" "dkim3" {
  count = var.fastmail ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "fm3._domainkey"
  type            = "CNAME"
  value           = "fm3.${var.domain}.dkim.fmhosted.com"
  proxied         = false
}
