locals {
  domains = merge({
    // RIPE /40
    "0.f.4.4.d.7.e.0.a.2.ip6.arpa" = {},
    // RIPE /44
    "c.1.2.2.0.f.8.e.0.a.2.ip6.arpa" = {},
  }, var.domains)

  foxden_home_rdns = [
    {
      subzone = "9.6",
      zone    = "0.f.4.4.d.7.e.0.a.2.ip6.arpa",
    },
    {
      subzone = "a.0",
      zone    = "0.f.4.4.d.7.e.0.a.2.ip6.arpa",
    },
    {
      subzone = "b.0",
      zone    = "0.f.4.4.d.7.e.0.a.2.ip6.arpa",
    },
  ]

  default_vanity_nameserver = "doridian.net"
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  cloudns_auth_id  = var.cloudns_auth_id
  cloudns_password = var.cloudns_password

  fastmail          = false
  ses               = false
  add_www_cname     = false
  vanity_nameserver = local.vanity_nameservers[try(each.value.vanity_nameserver, local.default_vanity_nameserver)]

  registrar = ""
}

resource "cloudns_dns_record" "foxden_home_rdns_1" {
  count = length(local.foxden_home_rdns)

  zone = local.foxden_home_rdns[count.index].zone

  type  = "NS"
  name  = local.foxden_home_rdns[count.index].subzone
  ttl   = 86400
  value = "ns1-ip.foxden.network"
}


resource "cloudns_dns_record" "foxden_home_rdns_2" {
  count = length(local.foxden_home_rdns)

  zone = local.foxden_home_rdns[count.index].zone

  type  = "NS"
  name  = local.foxden_home_rdns[count.index].subzone
  ttl   = 86400
  value = "ns2-ip.foxden.network"
}


resource "cloudns_dns_record" "foxden_home_rdns_3" {
  count = length(local.foxden_home_rdns)

  zone = local.foxden_home_rdns[count.index].zone

  type  = "NS"
  name  = local.foxden_home_rdns[count.index].subzone
  ttl   = 86400
  value = "ns3-ip.foxden.network"
}


resource "cloudns_dns_record" "foxden_home_rdns_4" {
  count = length(local.foxden_home_rdns)

  zone = local.foxden_home_rdns[count.index].zone

  type  = "NS"
  name  = local.foxden_home_rdns[count.index].subzone
  ttl   = 86400
  value = "ns4-ip.foxden.network"
}
