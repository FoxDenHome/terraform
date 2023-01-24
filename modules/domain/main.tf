locals {
  extra_attributes = merge({
  }, var.extra_attributes)
}

module "ses" {
  count     = var.ses ? 1 : 0
  source    = "./ses"
  zone      = cloudflare_zone.zone
  subdomain = ""
}

resource "cloudflare_zone" "zone" {
  zone = var.domain

  lifecycle {
    ignore_changes = [
      account_id,
    ]
  }
}
