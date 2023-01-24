
data "dns_a_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.cloudns_ns_list[count.index]
}

data "dns_aaaa_record_set" "ns" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0

  host = local.cloudns_ns_list[count.index]
}

resource "hexonet_nameserver" "glue" {
  count = (local.ns_same_domain && var.registrar == "hexonet") ? length(local.vanity_ns_list) : 0
  host  = "ns${count.index + 1}.${var.domain}"

  ip_addresses = concat(data.dns_a_record_set.ns[count.index].addrs, data.dns_aaaa_record_set.ns[count.index].addrs)
}

resource "cloudns_dns_record" "ns_a" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  zone  = var.domain

  name  = "ns${count.index + 1}"
  type  = "A"
  ttl   = 86400
  value = data.dns_a_record_set.ns[count.index].addrs[0]
}

module "ipv6expand" {
  count  = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  source = "../ipv6expand"
  ipv6   = data.dns_aaaa_record_set.ns[count.index].addrs[0]
}

resource "cloudns_dns_record" "ns_aaaa" {
  count = local.ns_same_domain ? length(local.vanity_ns_list) : 0
  zone  = var.domain

  name  = "ns${count.index + 1}"
  type  = "AAAA"
  ttl   = 86400
  value = module.ipv6expand[count.index].ipv6
}
