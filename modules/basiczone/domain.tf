locals {
  has_vanity_ns      = var.vanity_nameserver != null
  ns_same_domain     = local.has_vanity_ns ? (var.vanity_nameserver.name == var.domain) : false
  vanity_ns_list     = local.has_vanity_ns ? [for ns in split(",", var.vanity_nameserver.nameserver_list_string) : trimspace(ns)] : []
  constellix_ns_list = ["ns11.constellix.com", "ns21.constellix.com", "ns31.constellix.com", "ns41.constellix.net", "ns51.constellix.net", "ns61.constellix.net"]
}

resource "constellix_domain" "domain" {
  name              = var.domain
  vanity_nameserver = local.has_vanity_ns ? var.vanity_nameserver.id : null
}

data "dns_a_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.constellix_ns_list[count.index]
}

data "dns_aaaa_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.constellix_ns_list[count.index]
}

resource "aws_route53domains_registered_domain" "domain" {
  count       = var.aws_registrar ? 1 : 0
  domain_name = var.domain

  auto_renew         = true
  registrant_privacy = true
  admin_privacy      = true
  tech_privacy       = true
  transfer_lock      = var.transfer_lock

  dynamic "name_server" {
    for_each = local.has_vanity_ns ? local.vanity_ns_list : local.constellix_ns_list
    content {
      name     = name_server.value
      glue_ips = local.ns_same_domain ? concat(data.dns_a_record_set.ns[name_server.key].addrs, data.dns_aaaa_record_set.ns[name_server.key].addrs) : null
    }
  }
}

resource "constellix_a_record" "ns" {
  count     = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  domain_id = constellix_domain.domain.id

  name        = "ns${count.index + 1}"
  type        = "A"
  ttl         = 3600
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
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = module.ipv6expand[count.index].ipv6
    disable_flag = false
  }
}

module "aws_sub" {
  count  = var.ses ? 1 : 0
  source = "./aws"
  domain = constellix_domain.domain
}
