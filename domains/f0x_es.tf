locals {
  f0x_es_domain = module.domain["f0x.es"].domain.id
}

resource "constellix_cname_record" "f0x_es_c0de" {
  domain_id = local.f0x_es_domain

  type        = "CNAME"
  name        = "c0de"
  ttl         = 3600
  source_type = "domains"

  host = "c0defox.es."
}

resource "constellix_cname_record" "f0x_es_vixus" {
  domain_id = local.f0x_es_domain

  type        = "CNAME"
  name        = "vixus"
  ttl         = 3600
  source_type = "domains"

  host = "arcticfox.doridian.net."
}
