locals {
  cloudflare_zone = module.basiczone.zone.id
}

module "basiczone" {
  source = "../../cloudflare/modules/basiczone"

  account_id  = var.cloudflare_account_id
  main_domain = "spaceage.mp"
  domain      = "spaceage.mp"

  fastmail             = true
  ses                  = true
  redirect_all_to_main = false
  redirect_www_to_root = true
  add_www_cname        = true
}

resource "cloudflare_record" "spaceage_mp_redfox" {
  allow_overwrite = true
  zone_id         = local.cloudflare_zone

  for_each = toset(["@", "api", "forums", "static", "tts"])

  type    = "CNAME"
  name    = each.value
  value   = "redfox.doridian.net"
  proxied = false
}

resource "cloudflare_record" "spaceage_mp_local" {
  allow_overwrite = true
  zone_id         = local.cloudflare_zone

  type    = "A"
  name    = "local"
  value   = "127.0.0.1"
  proxied = false
}

resource "cloudflare_page_rule" "spaceage_mp_api" {
  zone_id = local.cloudflare_zone

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
  zone_id = local.cloudflare_zone

  status   = "active"
  priority = 3
  target   = "https://static.spaceage.mp/*"
  actions {
    cache_level      = "cache_everything"
    disable_security = true
    security_level   = "essentially_off"
  }
}
