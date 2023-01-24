resource "cloudns_dns_record" "foxden_network_wildcard" {
  zone = "foxden.network"

  type  = "CNAME"
  name  = "*"
  ttl   = 3600
  value = "redfox.doridian.net"
}

resource "cloudns_dns_record" "foxden_network_ntp" {
  zone = "foxden.network"

  type  = "CNAME"
  name  = "ntp"
  ttl   = 3600
  value = "ntp.dyn.foxden.network"
}

resource "cloudns_dns_record" "foxden_network_nas_ro" {
  zone = "foxden.network"

  type  = "A"
  name  = "nas-ro"
  ttl   = 3600
  value = "116.202.171.116"
}

resource "cloudns_dns_record" "foxden_network_wan" {
  zone = "foxden.network"

  for_each = toset(["vpn", "factorio"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "wan.dyn.foxden.network"
}

resource "cloudns_dns_record" "foxden_network_todyn" {
  zone = "foxden.network"

  for_each = toset(["router", "router-backup"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "${each.value}.dyn.foxden.network"
}

resource "cloudns_dns_record" "foxden_network_dyn" {
  for_each = toset(["ns1.he.net", "ns2.he.net", "ns3.he.net", "ns4.he.net", "ns5.he.net"])
  zone     = "foxden.network"

  type  = "NS"
  name  = "dyn"
  ttl   = 86400
  value = each.value
}

resource "cloudns_dns_record" "foxden_home_rdns_ns" {
  for_each = toset(["ip6", "ip4"])
  zone     = "foxden.network"

  type  = "NS"
  name  = each.value
  ttl   = 86400
  value = "ns-ip.foxden.network"
}


resource "cloudns_dns_record" "foxden_home_rdns_a" {
  zone = "foxden.network"

  type  = "A"
  name  = "ns-ip"
  ttl   = 86400
  value = "66.42.71.230"
}

resource "cloudns_dns_record" "foxden_home_rdns_aaaa" {
  zone = "foxden.network"

  type  = "AAAA"
  name  = "ns-ip"
  ttl   = 86400
  value = "2a0e:7d44:f000:0:0:0:0:e621"
}
