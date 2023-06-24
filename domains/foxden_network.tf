locals {
  foxden_network_redfox = toset(["redfox", "ns-ip"])
}

resource "cloudns_dns_record" "foxden_network_redfox" {
  for_each = toset([
    "git",
    "grafana",
    "homeassistant",
    "nas",
    "s3",
  ])
  zone = "foxden.network"

  type  = "ALIAS"
  name  = each.value
  ttl   = 3600
  value = "redfox.foxden.network"
}

resource "cloudns_dns_record" "foxden_network_nas_ro" {
  zone = "foxden.network"

  type  = "A"
  name  = "nas-ro"
  ttl   = 3600
  value = "107.181.226.74"
}

resource "cloudns_dns_record" "foxden_network_wan" {
  zone = "foxden.network"

  for_each = toset(["vpn", "factorio"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "wan.foxden.network"
}

resource "cloudns_dns_record" "foxden_home_rdns_ns" {
  for_each = toset(["ip6", "ip4"])
  zone     = "foxden.network"

  type  = "NS"
  name  = each.value
  ttl   = 86400
  value = "ns-ip.foxden.network"
}

resource "cloudns_dns_record" "foxden_home_redfox_a" {
  for_each = local.foxden_network_redfox
  zone     = "foxden.network"

  type  = "A"
  name  = each.value
  ttl   = 86400
  value = local.redfox.ipv4
}

resource "cloudns_dns_record" "foxden_home_redfox_aaaa" {
  for_each = local.foxden_network_redfox
  zone     = "foxden.network"

  type  = "AAAA"
  name  = each.value
  ttl   = 86400
  value = local.redfox.ipv6
}

resource "cloudns_dns_record" "foxden_home_dyn" {
  zone = "foxden.network"

  for_each = toset(["wan", "ntp", "router", "router-backup"])

  type  = "A"
  name  = each.value
  ttl   = 300
  value = "127.0.0.1"

  lifecycle {
    ignore_changes = [value]
  }
}
