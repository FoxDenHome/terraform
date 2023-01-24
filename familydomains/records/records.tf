resource "cloudflare_record" "cnames" {
  for_each = toset(["ftp", "mail", "mysql", "pop", "smtp", "www.mail"])
  zone_id  = var.zone.id

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "${var.zone.zone}."
}

resource "cloudflare_record" "mx" {
  zone_id = var.zone.id

  type = "MX"
  name = "@"
  ttl  = 3600

  value    = "${var.server}."
  priority = 1
}
