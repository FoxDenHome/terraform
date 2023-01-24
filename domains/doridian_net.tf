locals {
  doridian_net_zone = module.domain["doridian.net"].zone
}

# redfox
resource "cloudflare_record" "doridian_net_redfox_a" {
  zone_id = local.doridian_net_zone.id

  type  = "A"
  name  = "redfox"
  ttl   = 3600
  value = "66.42.71.230"
}

resource "cloudflare_record" "doridian_net_redfox_aaaa" {
  zone_id = local.doridian_net_zone.id

  type  = "AAAA"
  name  = "redfox"
  ttl   = 3600
  value = "2a0e:8f02:21c0:0:0:0:0:e621"
}

resource "cloudflare_record" "doridian_net_redfox_syncthing" {
  zone_id = local.doridian_net_zone.id

  type  = "CNAME"
  name  = "syncthing"
  ttl   = 3600
  value = "redfox.doridian.net."
}


# icefox
resource "cloudflare_record" "doridian_net_icefox_a" {
  zone_id = local.doridian_net_zone.id

  type  = "A"
  name  = "icefox"
  ttl   = 3600
  value = "116.202.171.116"
}

# arcticfox
resource "cloudflare_record" "doridian_net_arcticfox_a" {
  zone_id = local.doridian_net_zone.id

  type  = "A"
  name  = "arcticfox"
  ttl   = 3600
  value = "81.4.122.10"
}

resource "cloudflare_record" "doridian_net_arcticfox_aaaa" {
  zone_id = local.doridian_net_zone.id

  type  = "AAAA"
  name  = "arcticfox"
  ttl   = 3600
  value = "2a00:d880:11:0:0:0:0:348"
}

resource "cloudflare_record" "doridian_net_arcticfox_mysql" {
  zone_id = local.doridian_net_zone.id

  type  = "CNAME"
  name  = "mysql"
  ttl   = 3600
  value = "arcticfox.doridian.net."
}

resource "cloudflare_record" "doridian_net_arcticfox_www" {
  zone_id = local.doridian_net_zone.id

  type  = "CNAME"
  name  = "www.arcticfox"
  ttl   = 3600
  value = "arcticfox.doridian.net."
}

resource "cloudflare_record" "doridian_net_arcticfox_spf" {
  zone_id = local.doridian_net_zone.id

  type  = "TXT"
  name  = "arcticfox"
  ttl   = 3600
  value = "v=spf1 +a:arcticfox.doridian.net include:amazonses.com mx ~all"
}

module "arcticfox_ses" {
  source    = "../modules/domain/ses"
  zone      = local.doridian_net_zone
  subdomain = "arcticfox"
}
