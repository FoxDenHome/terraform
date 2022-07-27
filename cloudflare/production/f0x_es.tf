locals {
  f0x_es_zone = module.basiczone["f0x.es"].zone.id
}

resource "cloudflare_record" "f0x_es_root" {
  allow_overwrite = true
  zone_id         = local.f0x_es_zone

  type    = "CNAME"
  name    = "@"
  value   = "redfox.doridian.net"
  proxied = false
}

resource "cloudflare_record" "f0x_es_c0de" {
  allow_overwrite = true
  zone_id         = local.f0x_es_zone

  type    = "CNAME"
  name    = "c0de"
  value   = "c0defox.es"
  proxied = false
}

resource "cloudflare_record" "f0x_es_vixus" {
  allow_overwrite = true
  zone_id         = local.f0x_es_zone

  type    = "CNAME"
  name    = "vixus"
  value   = "arcticfox.doridian.net"
  proxied = false
}
