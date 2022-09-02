resource "constellix_aname_record" "root" {
  domain_id = var.domain.id

  type        = "ANAME"
  name        = ""
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "${var.server}."
    disable_flag = false
  }
}

resource "constellix_cname_record" "cnames" {
  domain_id = var.domain.id

  for_each = toset(["ftp", "mail", "mysql", "pop", "smtp", "www", "www.mail"])

  type        = "CNAME"
  name        = each.value
  ttl         = 3600
  source_type = "domains"

  host = "${var.domain.name}."
}

resource "constellix_mx_record" "mx" {
  domain_id = var.domain.id

  type        = "MX"
  name        = ""
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = "${var.server}."
    level = 1
  }
}
