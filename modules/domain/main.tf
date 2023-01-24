locals {
  has_vanity_ns   = var.vanity_nameserver != null
  ns_same_domain  = local.has_vanity_ns ? (var.vanity_nameserver.name == var.domain) : false
  vanity_ns_list  = local.has_vanity_ns ? var.vanity_nameserver.list : null
  cloudns_ns_list = ["pns41.cloudns.net", "pns42.cloudns.net", "pns43.cloudns.net", "pns44.cloudns.net"]

  used_ns_list = local.has_vanity_ns ? local.vanity_ns_list : local.cloudns_ns_list

  extra_attributes = merge({
  }, var.extra_attributes)
}

module "ses" {
  count     = var.ses ? 1 : 0
  source    = "./ses"
  zone      = var.domain
  subdomain = ""
}
