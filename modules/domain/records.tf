resource "cloudflare_record" "root" {
  count   = var.root_aname != null ? 1 : 0
  zone_id = cloudflare_zone.zone.id

  name  = "@"
  type  = "CNAME"
  ttl   = 3600
  value = "${var.root_aname}."
}

resource "cloudflare_record" "www" {
  count   = var.add_www_cname ? 1 : 0
  zone_id = cloudflare_zone.zone.id

  name  = "www"
  type  = "CNAME"
  ttl   = 3600
  value = "${var.domain}."
}

resource "cloudflare_record" "spf" {
  count   = (var.ses || var.fastmail) ? 1 : 0
  zone_id = cloudflare_zone.zone.id

  name  = "@"
  type  = "TXT"
  ttl   = 3600
  value = "v=spf1 ${var.fastmail ? "include:spf.messagingengine.com" : ""} ${var.ses ? "include:amazonses.com" : ""} mx ~all"
}
