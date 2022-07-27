resource "cloudflare_zone_settings_override" "settings" {
  zone_id = cloudflare_zone.zone.id

  settings {
    http3 = "on"

    websockets = "on"

    always_use_https = "on"
    tls_1_3          = "on"
    ssl              = "strict"
    security_header {
      enabled            = true
      preload            = true
      include_subdomains = true
      nosniff            = true
      max_age            = 31536000
    }
  }
}

resource "cloudflare_zone_dnssec" "dnssec" {
  zone_id = cloudflare_zone.zone.id
}
