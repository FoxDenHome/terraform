locals {
  foxden_network_domain = module.domain["foxden.network"].domain.id
}

resource "constellix_cname_record" "foxden_network_wildcard" {
  domain_id = local.foxden_network_domain

  type        = "CNAME"
  name        = "*"
  ttl         = 3600
  source_type = "domains"

  host = "redfox.doridian.net."
}

resource "constellix_cname_record" "foxden_network_ntp" {
  domain_id = local.foxden_network_domain

  type        = "CNAME"
  name        = "ntp"
  ttl         = 3600
  source_type = "domains"

  host = "ntp.dyn.foxden.network."
}

resource "constellix_a_record" "foxden_network_nas_ro" {
  domain_id = local.foxden_network_domain

  type        = "A"
  name        = "nas-ro"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "116.202.171.116"
    disable_flag = false
  }
}

resource "constellix_cname_record" "foxden_network_router" {
  domain_id = local.foxden_network_domain

  for_each = toset(["router", "vpn", "factorio"])

  type        = "CNAME"
  name        = each.value
  ttl         = 3600
  source_type = "domains"

  host = "router.dyn.foxden.network."
}

resource "constellix_ns_record" "foxden_network_dyn" {
  domain_id = local.foxden_network_domain

  type        = "NS"
  name        = "dyn"
  ttl         = 86400
  source_type = "domains"

  dynamic "roundrobin" {
    for_each = toset(["ns1.he.net.", "ns2.he.net.", "ns3.he.net.", "ns4.he.net.", "ns5.he.net."])
    content {
      value        = roundrobin.value
      disable_flag = false
    }
  }
}

resource "constellix_ns_record" "foxden_home_rdns" {
  for_each = toset(["ip6", "ip4"])

  domain_id = local.foxden_network_domain

  type        = "NS"
  name        = each.value
  ttl         = 86400
  source_type = "domains"

  roundrobin {
    value        = "ns-ip.foxden.network."
    disable_flag = false
  }
}


resource "constellix_a_record" "foxden_home_rdns" {
  domain_id = local.foxden_network_domain

  type        = "A"
  name        = "ns-ip"
  ttl         = 86400
  source_type = "domains"

  roundrobin {
    value        = "66.42.71.230"
    disable_flag = false
  }
}

resource "constellix_aaaa_record" "foxden_home_rdns" {
  domain_id = local.foxden_network_domain

  type        = "AAAA"
  name        = "ns-ip"
  ttl         = 86400
  source_type = "domains"

  roundrobin {
    value        = "2a0e:7d44:f000:0:0:0:0:e621"
    disable_flag = false
  }
}
