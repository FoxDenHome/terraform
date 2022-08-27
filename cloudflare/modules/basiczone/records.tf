resource "cloudflare_record" "root" {
  count = var.redirect_all_to_main ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "@"
  type            = "CNAME"
  value           = var.main_domain
  proxied         = true
}

resource "cloudflare_record" "www" {
  count = var.add_www_cname ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "www"
  type            = "CNAME"
  value           = var.domain
  proxied         = true
}

resource "cloudflare_record" "spf" {
  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id
  name            = "@"
  type            = "TXT"
  value           = "v=spf1 ${var.fastmail ? "include:spf.messagingengine.com" : ""} ${var.ses ? "include:amazonses.com" : ""} mx ~all"
}
