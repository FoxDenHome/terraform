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

  default_vanity_nameserver = "doridian.net"
}

data "constellix_vanity_nameserver" "vanity" {
  for_each = { for k, zone in local.domains : try(zone.vanity_nameserver, local.default_vanity_nameserver) => true... if try(zone.vanity_nameserver, local.default_vanity_nameserver) != null }

  name = each.key
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail          = false
  ses               = false
  add_www_cname     = false
  vanity_nameserver = try(each.value.vanity_nameserver, local.default_vanity_nameserver) != null ? data.constellix_vanity_nameserver.vanity[try(each.value.vanity_nameserver, local.default_vanity_nameserver)] : null

  registrar = ""
}
