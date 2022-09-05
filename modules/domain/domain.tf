locals {
  has_vanity_ns      = var.vanity_nameserver != null
  ns_same_domain     = local.has_vanity_ns ? (var.vanity_nameserver.name == var.domain) : false
  vanity_ns_list     = local.has_vanity_ns ? [for ns in split(",", var.vanity_nameserver.nameserver_list_string) : trimspace(ns)] : []
  constellix_ns_list = ["ns11.constellix.com", "ns21.constellix.com", "ns31.constellix.com", "ns41.constellix.net", "ns51.constellix.net", "ns61.constellix.net"]

  extra_attributes = merge({
  }, var.extra_attributes)
}

resource "constellix_domain" "domain" {
  name              = var.domain
  vanity_nameserver = local.has_vanity_ns ? var.vanity_nameserver.id : null
  soa = {
    primary_nameserver = local.has_vanity_ns ? "${local.vanity_ns_list[0]}." : "${local.constellix_ns_list[0]}."
    email              = local.has_vanity_ns ? "dns.${var.vanity_nameserver.name}." : "dns.constellix.com."
    expire             = 1209600
    negcache           = 180
    refresh            = 43200
    retry              = 3600
    ttl                = 86400
  }
}

data "dns_a_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.constellix_ns_list[count.index]
}

data "dns_aaaa_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.constellix_ns_list[count.index]
}

resource "hexonet_domain" "domain" {
  count  = var.hexonet_registrar ? 1 : 0
  domain = var.domain

  name_servers  = local.has_vanity_ns ? local.vanity_ns_list : local.constellix_ns_list

  owner_contacts   = var.owner_contacts
  admin_contacts   = var.admin_contacts
  tech_contacts    = var.tech_contacts
  billing_contacts = var.billing_contacts

  extra_attributes = var.extra_attributes
  status = [
    "ACTIVE",
    "clientDeleteProhibited",
    "clientTransferProhibited",
  ]
}

resource "hexonet_nameserver" "glue" {
  count = (local.ns_same_domain && var.hexonet_registrar) ? length(local.vanity_ns_list) : 0
  host  = "ns${count.index + 1}.${var.domain}"

  ip_addresses = concat(data.dns_a_record_set.ns[count.index].addrs, data.dns_aaaa_record_set.ns[count.index].addrs)
}

resource "constellix_a_record" "ns" {
  count     = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  domain_id = constellix_domain.domain.id

  name        = "ns${count.index + 1}"
  type        = "A"
  ttl         = 86400
  source_type = "domains"

  roundrobin {
    value        = data.dns_a_record_set.ns[count.index].addrs[0]
    disable_flag = false
  }
}

module "ipv6expand" {
  count  = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  source = "../ipv6expand"
  ipv6   = data.dns_aaaa_record_set.ns[count.index].addrs[0]
}

resource "constellix_aaaa_record" "vanityns" {
  count     = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  domain_id = constellix_domain.domain.id

  name        = "ns${count.index + 1}"
  type        = "AAAA"
  ttl         = 86400
  source_type = "domains"

  roundrobin {
    value        = module.ipv6expand[count.index].ipv6
    disable_flag = false
  }
}
