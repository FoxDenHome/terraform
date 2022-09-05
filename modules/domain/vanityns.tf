
data "dns_a_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.constellix_ns_list[count.index]
}

data "dns_aaaa_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.constellix_ns_list[count.index]
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

resource "constellix_aaaa_record" "ns" {
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
