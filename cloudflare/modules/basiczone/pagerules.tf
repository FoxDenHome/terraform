resource "cloudflare_page_rule" "redirect_all_to_main" {
  count = var.redirect_all_to_main ? 1 : 0

  zone_id  = cloudflare_zone.zone.id
  target   = "https://*${var.domain}/*"
  priority = 1
  status   = "active"

  actions {
    forwarding_url {
      url         = "https://doridian.net"
      status_code = 302
    }
  }
}

resource "cloudflare_page_rule" "redirect_www_to_root" {
  count = var.redirect_www_to_root ? 1 : 0

  zone_id  = cloudflare_zone.zone.id
  target   = "https://www.${var.domain}/*"
  priority = 1
  status   = "active"

  actions {
    forwarding_url {
      url         = "https://${var.domain}"
      status_code = 302
    }
  }
}
