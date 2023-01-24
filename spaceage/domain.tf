module "domain" {
  source = "../modules/domain"

  domain = local.main_domain

  fastmail      = true
  ses           = true
  root_aname    = "redfox.doridian.net"
  add_www_cname = true
  registrar     = "dotmp"
}

resource "cloudflare_record" "spaceage_mp_redfox" {
  zone_id = local.zone_id

  for_each = toset(["api", "static", "tts"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "redfox.doridian.net."
}

resource "cloudflare_record" "spaceage_mp_local" {
  zone_id = local.zone_id

  type  = "A"
  name  = "local"
  ttl   = 3600
  value = "127.0.0.1"
}
