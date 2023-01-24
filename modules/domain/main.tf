locals {
  has_vanity_ns      = var.vanity_nameserver != null
  ns_same_domain     = local.has_vanity_ns ? (var.vanity_nameserver.name == var.domain) : false
  vanity_ns_list     = local.has_vanity_ns ? [for ns in split(",", var.vanity_nameserver.nameserver_list_string) : trimspace(ns)] : []
  constellix_ns_list = ["ns11.constellix.com", "ns21.constellix.com", "ns31.constellix.com", "ns41.constellix.net", "ns51.constellix.net", "ns61.constellix.net"]

  extra_attributes = merge({
  }, var.extra_attributes)

  dnssec_ds_record     = "${cloudflare_zone_dnssec.zone.key_tag} ${cloudflare_zone_dnssec.zone.algorithm} ${cloudflare_zone_dnssec.zone.digest_type} ${cloudflare_zone_dnssec.zone.digest}"
  dnssec_dnskey_record = "${cloudflare_zone_dnssec.zone.flags} 3 ${cloudflare_zone_dnssec.zone.algorithm} ${cloudflare_zone_dnssec.zone.public_key}"
}

module "ses" {
  count     = var.ses ? 1 : 0
  source    = "./ses"
  domain    = constellix_domain.domain
  subdomain = ""
}

resource "constellix_domain" "domain" {
  name              = var.domain
  vanity_nameserver = local.has_vanity_ns ? var.vanity_nameserver.id : null
  soa = {
    primary_nameserver = local.has_vanity_ns ? "${local.vanity_ns_list[0]}." : "${local.constellix_ns_list[0]}."
    email              = local.has_vanity_ns ? "dns.${var.vanity_nameserver.name}." : "dns.constellix.com."
    expire             = 1209600
    negcache           = 180
    refresh            = 43200
    retry              = 3600
    ttl                = 86400
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
