locals {
    foxcav_es_zone = module.basiczone["foxcav.es"].zone.id
}

resource "cloudflare_record" "foxcav_es_root" {
    allow_overwrite = true
    zone_id = local.foxcav_es_zone

    type = "CNAME"
    name = "@"
    value = "redfox.doridian.net"
    proxied = false
}
