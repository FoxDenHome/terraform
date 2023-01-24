resource "cloudns_dns_record" "cnames" {
  zone = var.zone

  for_each = toset(["ftp", "mail", "mysql", "pop", "smtp", "www.mail"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = var.zone
}

resource "cloudns_dns_record" "mx" {
  zone = var.zone

  type     = "MX"
  name     = ""
  ttl      = 3600
  value    = var.server
  priority = 1
}
