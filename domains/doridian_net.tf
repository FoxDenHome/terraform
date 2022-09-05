locals {
  doridian_net_domain = module.domain["doridian.net"].domain
}

# redfox
resource "constellix_a_record" "doridian_net_redfox_a" {
  domain_id = local.doridian_net_domain.id

  type        = "A"
  name        = "redfox"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "66.42.78.232"
    disable_flag = false
  }
}

resource "constellix_aaaa_record" "doridian_net_redfox_aaaa" {
  domain_id = local.doridian_net_domain.id

  type        = "AAAA"
  name        = "redfox"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "2a0e:8f02:21c0:0:0:0:0:e621"
    disable_flag = false
  }
}

resource "constellix_cname_record" "doridian_net_redfox_syncthing" {
  domain_id = local.doridian_net_domain.id

  type        = "CNAME"
  name        = "syncthing"
  ttl         = 3600
  source_type = "domains"

  host = "redfox.doridian.net."
}


# icefox
resource "constellix_a_record" "doridian_net_icefox_a" {
  domain_id = local.doridian_net_domain.id

  type        = "A"
  name        = "icefox"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "116.202.171.116"
    disable_flag = false
  }
}

# arcticfox
resource "constellix_a_record" "doridian_net_arcticfox_a" {
  domain_id = local.doridian_net_domain.id

  type        = "A"
  name        = "arcticfox"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "81.4.122.10"
    disable_flag = false
  }
}

resource "constellix_aaaa_record" "doridian_net_arcticfox_aaaa" {
  domain_id = local.doridian_net_domain.id

  type        = "AAAA"
  name        = "arcticfox"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "2a00:d880:11:0:0:0:0:348"
    disable_flag = false
  }
}

resource "constellix_cname_record" "doridian_net_arcticfox_mysql" {
  domain_id = local.doridian_net_domain.id

  type        = "CNAME"
  name        = "mysql"
  ttl         = 3600
  source_type = "domains"

  host = "arcticfox.doridian.net."
}

resource "constellix_cname_record" "doridian_net_arcticfox_www" {
  domain_id = local.doridian_net_domain.id

  type        = "CNAME"
  name        = "www.arcticfox"
  ttl         = 3600
  source_type = "domains"

  host = "arcticfox.doridian.net."
}

resource "constellix_txt_record" "doridian_net_arcticfox_spf" {
  domain_id = local.doridian_net_domain.id

  type        = "TXT"
  name        = "arcticfox"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = "v=spf1 +a:arcticfox.doridian.net include:amazonses.com mx ~all"
  }
}

module "arcticfox_ses" {
  source    = "../modules/domain/ses"
  domain    = local.doridian_net_domain
  subdomain = "arcticfox"
}
