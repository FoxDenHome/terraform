locals {
    spaceage_mp_zone = module.basiczone["spaceage.mp"].zone.id
}

resource "cloudflare_record" "spaceage_mp_redfox" {
    allow_overwrite = true
    zone_id = local.spaceage_mp_zone

    for_each = toset(["@", "api", "forums", "static", "tts"])

    type = "CNAME"
    name = each.value
    value = "redfox.doridian.net"
    proxied = false
}

resource "cloudflare_record" "spaceage_mp_local" {
    allow_overwrite = true
    zone_id = local.spaceage_mp_zone

    type = "A"
    name = "local"
    value = "127.0.0.1"
    proxied = false
}

resource "cloudflare_page_rule" "spaceage_mp_api" {
  zone_id  = local.spaceage_mp_zone

  status = "active"
  priority = 2
  target   = "https://api.spaceage.mp/*"
  actions {
    cache_level      = "cache_everything"
    disable_security = true
    security_level   = "essentially_off"
  }
}

resource "cloudflare_page_rule" "spaceage_mp_static" {
  zone_id  = local.spaceage_mp_zone

  status = "active"
  priority = 3
  target   = "https://static.spaceage.mp/*"
  actions {
    cache_level      = "cache_everything"
    disable_security = true
    security_level   = "essentially_off"
  }
}
