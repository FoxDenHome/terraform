locals {
  doridian_net_zone = module.basiczone["doridian.net"].zone.id
}

resource "cloudflare_record" "doridian_net_root" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type    = "CNAME"
  name    = "@"
  value   = var.main_domain_target
  proxied = true
}


# redfox
resource "cloudflare_record" "doridian_net_redfox_a" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type    = "A"
  name    = "redfox"
  value   = "45.151.132.166"
  proxied = false
}

resource "cloudflare_record" "doridian_net_redfox_aaaa" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type    = "AAAA"
  name    = "redfox"
  value   = "2a0e:8f02:21c0::e621"
  proxied = false
}

resource "cloudflare_record" "doridian_net_redfox_syncthing" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type  = "CNAME"
  name  = "syncthing"
  value = "redfox.doridian.net"
}


# icefox
resource "cloudflare_record" "doridian_net_icefox_a" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type    = "A"
  name    = "icefox"
  value   = "116.202.171.116"
  proxied = false
}


# arcticfox
resource "cloudflare_record" "doridian_net_arcticfox_a" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type    = "A"
  name    = "arcticfox"
  value   = "81.4.122.10"
  proxied = false
}

resource "cloudflare_record" "doridian_net_arcticfox_aaaa" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type    = "AAAA"
  name    = "arcticfox"
  value   = "2a00:d880:11::348"
  proxied = false
}

resource "cloudflare_record" "doridian_net_arcticfox_mysql" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type  = "CNAME"
  name  = "mysql"
  value = "arcticfox.doridian.net"
}

resource "cloudflare_record" "doridian_net_arcticfox_www" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type  = "CNAME"
  name  = "www.arcticfox"
  value = "arcticfox.doridian.net"
}

resource "cloudflare_record" "doridian_net_arcticfox_spf" {
  allow_overwrite = true
  zone_id         = local.doridian_net_zone

  type  = "TXT"
  name  = "arcticfox"
  value = "v=spf1 +a:arcticfox.doridian.net include:amazonses.com mx ~all"
}
