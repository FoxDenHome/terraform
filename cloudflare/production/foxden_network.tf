locals {
    foxden_network_zone = module.basiczone["foxden.network"].zone.id
}

resource "cloudflare_record" "foxden_network_root" {
    allow_overwrite = true
    zone_id = local.foxden_network_zone

    type = "CNAME"
    name = "@"
    value = "redfox.doridian.net"
    proxied = false
}

resource "cloudflare_record" "foxden_network_wildcard" {
    allow_overwrite = true
    zone_id = local.foxden_network_zone

    type = "CNAME"
    name = "*"
    value = "redfox.doridian.net"
    proxied = false
}

resource "cloudflare_record" "foxden_network_ntp" {
    allow_overwrite = true
    zone_id = local.foxden_network_zone

    type = "CNAME"
    name = "ntp"
    value = "ntp.dyn.foxden.network"
    proxied = false
}

resource "cloudflare_record" "foxden_network_nas_ro" {
    allow_overwrite = true
    zone_id = local.foxden_network_zone

    type = "A"
    name = "nas-ro"
    value = "95.217.115.106"
    proxied = false
}

resource "cloudflare_record" "foxden_network_router" {
    allow_overwrite = true
    zone_id = local.foxden_network_zone

    for_each = toset(["router", "vpn", "factorio"])

    type = "CNAME"
    name = each.value
    value = "router.dyn.foxden.network"
    proxied = false
}

resource "cloudflare_record" "foxden_network_dyn" {
    allow_overwrite = true
    zone_id = local.foxden_network_zone

    for_each = toset(["ns1.he.net", "ns2.he.net", "ns3.he.net", "ns4.he.net", "ns5.he.net"])

    type = "NS"
    name = "dyn"
    value = each.value
    ttl = 3600
}
