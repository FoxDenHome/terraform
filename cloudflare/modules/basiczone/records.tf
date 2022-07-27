resource "cloudflare_record" "root" {
    allow_overwrite = true
    zone_id = var.zone_id
    name = "@"
    type = "CNAME"
    value = "doridian.net"
    proxied = true
}
