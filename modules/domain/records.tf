resource "cloudns_dns_record" "root" {
  count = var.root_aname != null ? 1 : 0
  zone  = var.domain

  name  = ""
  type  = "ALIAS"
  ttl   = var.root_aname_ttl
  value = var.root_aname
}

resource "cloudns_dns_record" "www" {
  count = var.add_www_cname ? 1 : 0
  zone  = var.domain

  name  = "www"
  type  = "CNAME"
  ttl   = 3600
  value = var.domain
}

resource "cloudns_dns_record" "spf" {
  count = (var.ses || var.fastmail) ? 1 : 0
  zone  = var.domain

  name  = ""
  type  = "TXT"
  ttl   = 3600
  value = join(" ", compact([
    "v=spf1",
    var.fastmail ? "include:spf.messagingengine.com" : "",
    var.ses ? "include:amazonses.com" : "",
    "mx",
    "~all",
  ]))
}

resource "cloudns_dns_record" "ns_ns" {
  count = length(local.used_ns_list)
  zone  = var.domain

  name  = ""
  type  = "NS"
  ttl   = 86400
  value = local.used_ns_list[count.index]
}
