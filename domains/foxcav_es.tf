locals {
  foxcav_es_domain = module.basiczone["foxcav.es"].domain.id
}

resource "constellix_aname_record" "foxcav_es_root" {
  domain_id = local.foxcav_es_domain

  type        = "ANAME"
  name        = ""
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "redfox.doridian.net."
    disable_flag = false
  }
}
