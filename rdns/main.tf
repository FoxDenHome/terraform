locals {
  domains = merge({
    // RIPE /40
    "0.f.4.4.d.7.e.0.a.2.ip6.arpa" = {
      vanity_nameserver = "doridian.net",
    },
    // RIPE /44
    "c.1.2.2.0.f.8.e.0.a.2.ip6.arpa" = {
      vanity_nameserver = "doridian.net",
    },
    // Tunnelbroker IPv6 /64
    "9.3.0.0.b.0.0.0.0.7.4.0.1.0.0.2.ip6.arpa" = {
      vanity_nameserver = "doridian.net",
    },
    // Tunnelbroker IPv6 /48
    "0.2.8.e.0.7.4.0.1.0.0.2.ip6.arpa" = {
      vanity_nameserver = "doridian.net",
    },
  }, var.domains)
}

data "constellix_vanity_nameserver" "vanity" {
  for_each = { for k, zone in local.domains : zone.vanity_nameserver => true... if zone.vanity_nameserver != null }

  name = each.key
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail          = false
  ses               = false
  add_www_cname     = false
  vanity_nameserver = try(data.constellix_vanity_nameserver.vanity[each.value.vanity_nameserver], null)

  registrar = ""
}
