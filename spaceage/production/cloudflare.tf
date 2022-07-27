locals {
  spaceage_mp_zone = module.basiczone.zone.id
  spaceage_tts_cdn = "d1x5a3iv2gxgba.cloudfront.net"
}

module "basiczone" {
  source = "../../cloudflare/modules/basiczone"

  account_id  = var.cloudflare_account_id
  main_domain = "spaceage.mp"
  domain      = "spaceage.mp"

  mx                   = true
  spf_additions        = "include:amazonses.com"
  redirect_all_to_main = false
  redirect_www_to_root = true
  add_www_cname        = true
}

resource "cloudflare_record" "spaceage_mp_redfox" {
  allow_overwrite = true
  zone_id         = local.spaceage_mp_zone

  for_each = toset(["@", "api", "forums", "static", "tts"])

  type    = "CNAME"
  name    = each.value
  value   = "redfox.doridian.net"
  proxied = false
}

resource "cloudflare_record" "spaceage_mp_local" {
  allow_overwrite = true
  zone_id         = local.spaceage_mp_zone

  type    = "A"
  name    = "local"
  value   = "127.0.0.1"
  proxied = false
}

resource "cloudflare_record" "spaceage_mp_tts_cdn" {
  allow_overwrite = true
  zone_id         = local.spaceage_mp_zone

  type    = "CNAME"
  name    = "tts-cdn"
  value   = local.spaceage_tts_cdn
  proxied = false
}

resource "cloudflare_page_rule" "spaceage_mp_api" {
  zone_id = local.spaceage_mp_zone

  status   = "active"
  priority = 2
  target   = "https://api.spaceage.mp/*"
  actions {
    cache_level      = "cache_everything"
    disable_security = true
    security_level   = "essentially_off"
  }
}

resource "cloudflare_page_rule" "spaceage_mp_static" {
  zone_id = local.spaceage_mp_zone

  status   = "active"
  priority = 3
  target   = "https://static.spaceage.mp/*"
  actions {
    cache_level      = "cache_everything"
    disable_security = true
    security_level   = "essentially_off"
  }
}
