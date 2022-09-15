resource "constellix_aname_record" "root" {
  count = var.root_aname != null ? 1 : 0

  domain_id   = constellix_domain.domain.id
  name        = ""
  type        = "ANAME"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "${var.root_aname}."
    disable_flag = false
  }
}

resource "constellix_cname_record" "www" {
  count = var.add_www_cname ? 1 : 0

  domain_id   = constellix_domain.domain.id
  name        = "www"
  type        = "CNAME"
  ttl         = 3600
  source_type = "domains"

  host = "${var.domain}."
}

resource "constellix_txt_record" "spf" {
  count = (var.ses || var.fastmail) ? 1 : 0

  domain_id   = constellix_domain.domain.id
  name        = ""
  type        = "TXT"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = "v=spf1 ${var.fastmail ? "include:spf.messagingengine.com" : ""} ${var.ses ? "include:amazonses.com" : ""} mx ~all"
  }
}
