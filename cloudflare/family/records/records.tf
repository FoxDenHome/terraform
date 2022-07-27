resource "cloudflare_record" "root" {
    allow_overwrite = true
    zone_id = var.zone.id

    type = "CNAME"
    name = "@"
    value = var.server
    proxied = false 
}

resource "cloudflare_record" "cnames" {
    allow_overwrite = true
    zone_id = var.zone.id

    for_each = toset(["ftp", "mail", "mysql", "pop", "smtp", "www", "www.mail"])

    type = "CNAME"
    name = each.value
    value = var.zone.zone
    proxied = false 
}

resource "cloudflare_record" "mx" {
    allow_overwrite = true
    zone_id = var.zone.id

    type = "MX"
    name = "@"
    value = var.server
    priority = 1
}

resource "cloudflare_record" "spf" {
    allow_overwrite = true
    zone_id = var.zone.id

    type = "TXT"
    name = "@"
    value = "v=spf1 +a:${var.server} +mx include:amazonses.com ~all"
}
