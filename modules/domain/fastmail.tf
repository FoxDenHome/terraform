resource "constellix_mx_record" "smtp" {
  count = var.fastmail ? 1 : 0
  domain_id   = constellix_domain.domain.id

  name        = ""
  type        = "MX"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "in1-smtp.messagingengine.com."
    level        = 10
    disable_flag = false
  }

  roundrobin {
    value        = "in2-smtp.messagingengine.com."
    level        = 20
    disable_flag = false
  }
}

resource "constellix_cname_record" "dkim1" {
  count = var.fastmail ? 1 : 0
  domain_id   = constellix_domain.domain.id

  name        = "fm1._domainkey"
  type        = "CNAME"
  ttl         = 3600
  source_type = "domains"

  host = "fm1.${var.domain}.dkim.fmhosted.com."
}

resource "constellix_cname_record" "dkim2" {
  count = var.fastmail ? 1 : 0

  domain_id   = constellix_domain.domain.id
  name        = "fm2._domainkey"
  type        = "CNAME"
  ttl         = 3600
  source_type = "domains"

  host = "fm2.${var.domain}.dkim.fmhosted.com."
}

resource "constellix_cname_record" "dkim3" {
  count = var.fastmail ? 1 : 0

  domain_id   = constellix_domain.domain.id
  name        = "fm3._domainkey"
  type        = "CNAME"
  ttl         = 3600
  source_type = "domains"

  host = "fm3.${var.domain}.dkim.fmhosted.com."
}
