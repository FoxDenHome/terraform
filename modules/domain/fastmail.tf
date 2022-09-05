resource "constellix_mx_record" "smtp" {
  count     = var.fastmail ? 1 : 0
  domain_id = constellix_domain.domain.id

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

resource "constellix_cname_record" "dkim" {
  count     = var.fastmail ? 3 : 0
  domain_id = constellix_domain.domain.id

  name        = "fm${count.index + 1}._domainkey"
  type        = "CNAME"
  ttl         = 3600
  source_type = "domains"

  host = "fm${count.index + 1}.${var.domain}.dkim.fmhosted.com."
}
