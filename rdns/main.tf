locals {
  domains = merge({
    // RIPE /40
    "0.f.4.4.d.7.e.0.a.2.ip6.arpa" = {},
    // RIPE /44
    "c.1.2.2.0.f.8.e.0.a.2.ip6.arpa" = {},
    // Tunnelbroker IPv6 /64
    "9.3.0.0.b.0.0.0.0.7.4.0.1.0.0.2.ip6.arpa" = {},
    // Tunnelbroker IPv6 /48
    "0.2.8.e.0.7.4.0.1.0.0.2.ip6.arpa" = {},
  }, var.domains)

  foxden_home_rdns = [
    {
      subzone = "9.6",
      zone    = "0.f.4.4.d.7.e.0.a.2.ip6.arpa",
    },
    {
      subzone = "a",
      zone    = "c.1.2.2.0.f.8.e.0.a.2.ip6.arpa",
    },
  ]

  default_vanity_nameserver = "doridian.net"
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail      = false
  ses           = false
  add_www_cname = false

  registrar = ""
}

resource "cloudflare_record" "foxden_home_rdns" {
  count = length(local.foxden_home_rdns)

  zone_id = module.domain[local.foxden_home_rdns[count.index].zone].zone.id

  type  = "NS"
  name  = local.foxden_home_rdns[count.index].subzone
  ttl   = 86400
  value = "ns-ip.foxden.network."
}
