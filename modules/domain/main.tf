locals {
  has_vanity_ns      = var.vanity_nameserver != null
  ns_same_domain     = local.has_vanity_ns ? (var.vanity_nameserver.name == var.domain) : false
  vanity_ns_list     = local.has_vanity_ns ? [for ns in split(",", var.vanity_nameserver.nameserver_list_string) : trimspace(ns)] : []
  constellix_ns_list = ["ns11.constellix.com", "ns21.constellix.com", "ns31.constellix.com", "ns41.constellix.net", "ns51.constellix.net", "ns61.constellix.net"]

  extra_attributes = merge({
  }, var.extra_attributes)
}

module "ses" {
  count     = var.ses ? 1 : 0
  source    = "./ses"
  domain    = constellix_domain.domain
  subdomain = ""
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

resource "hexonet_domain" "domain" {
  count  = var.hexonet_registrar ? 1 : 0
  domain = var.domain

  name_servers = local.has_vanity_ns ? local.vanity_ns_list : local.constellix_ns_list

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
