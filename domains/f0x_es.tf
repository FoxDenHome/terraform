locals {
  f0x_es_zone = module.domain["f0x.es"].zone.id
}

resource "cloudflare_record" "f0x_es_c0de" {
  zone_id = local.f0x_es_zone

  type  = "CNAME"
  name  = "c0de"
  ttl   = 3600
  value = "c0defox.es."
}

resource "cloudflare_record" "f0x_es_vixus" {
  zone_id = local.f0x_es_zone

  type  = "CNAME"
  name  = "vixus"
  ttl   = 3600
  value = "arcticfox.doridian.net."
}
