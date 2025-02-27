resource "cloudns_dns_record" "foxden_network_nas_ro_a" {
  zone = "foxden.network"

  type  = "A"
  name  = "nas-ro"
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "foxden_network_nas_ro_aaaa" {
  zone = "foxden.network"

  type  = "AAAA"
  name  = "nas-ro"
  ttl   = 3600
  value = "2a01:4f9:3b:4960::5"
}

# XMPP
locals {
  xmpp_hostnames = toset([
    "",
    "xmpp",
    "upload.xmpp",
    "muc.xmpp",
    "proxy.xmpp",
    "pubsub.xmpp",
  ])
}

resource "cloudns_dns_record" "foxden_network_xmpp_a" {
  for_each = local.xmpp_hostnames
  zone     = "foxden.network"

  type  = "A"
  name  = each.value
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "foxden_network_xmpp_aaaa" {
  for_each = local.xmpp_hostnames
  zone     = "foxden.network"

  type  = "AAAA"
  name  = each.value
  ttl   = 3600
  value = "2a01:4f9:3b:4960::4"
}

resource "cloudns_dns_record" "foxden_network_wan" {
  zone = "foxden.network"

  for_each = toset([
    "archlinux",
    "auth",
    "bengalfox-syncthing",
    "dav",
    "e621",
    "factorio",
    "furaffinity",
    "git",
    "grafana",
    "homeassistant",
    "htpl",
    "jellyfin",
    "mc",
    "minecraft",
    "nas",
    "ns-ip",
    "syncthing",
    "vpn",
    "restic",
  ])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "wan.foxden.network"
}

resource "cloudns_dns_record" "foxden_network_to_router" {
  zone = "foxden.network"

  for_each = toset([
    "ns1-ip",
    "ns3-ip",
  ])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "router.foxden.network"
}

resource "cloudns_dns_record" "foxden_network_to_router_backup" {
  zone = "foxden.network"

  for_each = toset([
    "ns2-ip",
    "ns4-ip",
  ])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "router-backup.foxden.network"
}

resource "cloudns_dns_record" "foxden_home_rdns_ns" {
  for_each = { for nsrec in setproduct(
    toset(["ns1-ip", "ns2-ip", "ns3-ip", "ns4-ip"]),
    toset(["ip6", "ip4"]),
  ) : join("-", nsrec) => nsrec }
  zone = "foxden.network"

  type  = "NS"
  name  = each.value[1]
  ttl   = 86400
  value = "${each.value[0]}.foxden.network"
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
