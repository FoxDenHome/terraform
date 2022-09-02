locals {
  domain_id   = module.domain.domain.id
  main_domain = "spaceage.mp"
}

resource "constellix_vanity_nameserver" "spaceage" {
  name                   = local.main_domain
  nameserver_group       = 1
  nameserver_list_string = "ns1.${local.main_domain},\nns2.${local.main_domain},\nns3.${local.main_domain},\nns4.${local.main_domain},\nns5.${local.main_domain},\nns6.${local.main_domain}"
}

data "constellix_vanity_nameserver" "spaceage" {
  name = "doridian.net"
}


module "domain" {
  source = "../modules/domain"

  main_domain = local.main_domain
  domain      = local.main_domain

  fastmail             = true
  ses                  = true
  add_root_aname       = false
  redirect_www_to_root = true
  add_www_cname        = true
  vanity_nameserver    = data.constellix_vanity_nameserver.spaceage
  aws_registrar        = false
}

resource "constellix_aname_record" "spaceage_mp_redfox" {
  domain_id = local.domain_id

  type        = "ANAME"
  name        = ""
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "redfox.doridian.net."
    disable_flag = false
  }
}

resource "constellix_cname_record" "spaceage_mp_redfox" {
  domain_id = local.domain_id

  for_each = toset(["api", "forums", "static", "tts"])

  type        = "CNAME"
  name        = each.value
  ttl         = 3600
  source_type = "domains"

  host = "redfox.doridian.net."
}

resource "constellix_a_record" "spaceage_mp_local" {
  domain_id = local.domain_id

  type        = "A"
  name        = "local"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "127.0.0.1"
    disable_flag = false
  }
}
