locals {
  extra_attributes = merge({
  }, var.extra_attributes)

  dnssec_ds_record     = "${cloudflare_zone_dnssec.zone.key_tag} ${cloudflare_zone_dnssec.zone.algorithm} ${cloudflare_zone_dnssec.zone.digest_type} ${cloudflare_zone_dnssec.zone.digest}"
  dnssec_dnskey_record = "${cloudflare_zone_dnssec.zone.flags} 3 ${cloudflare_zone_dnssec.zone.algorithm} ${cloudflare_zone_dnssec.zone.public_key}"
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

resource "cloudflare_zone_dnssec" "zone" {
  zone_id = cloudflare_zone.zone.id
}

resource "cloudflare_zone_settings_override" "zone" {
  zone_id = cloudflare_zone.zone.id

  settings {
    always_online     = "on"
    always_use_https  = "on"
    email_obfuscation = "off"

    http3      = "on"
    websockets = "on"

    universal_ssl   = "on"
    ssl             = "strict"
    tls_1_3         = "on"
    min_tls_version = "1.2"

    security_header {
      enabled            = true
      preload            = true
      max_age            = 31557600
      include_subdomains = true
      nosniff            = true
    }
  }
}
