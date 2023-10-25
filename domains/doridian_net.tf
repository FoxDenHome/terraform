# redfox
resource "cloudns_dns_record" "doridian_net_redfox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "redfox"
  ttl   = 3600
  value = local.redfox.ipv4
}

resource "cloudns_dns_record" "doridian_net_redfox_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "redfox"
  ttl   = 3600
  value = local.redfox.ipv6
}

resource "cloudns_dns_record" "doridian_net_redfox_syncthing" {
  zone = "doridian.net"

  type  = "CNAME"
  name  = "syncthing"
  ttl   = 3600
  value = "redfox.doridian.net"
}


# icefox
resource "cloudns_dns_record" "doridian_net_icefox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "icefox"
  ttl   = 3600
  value = "107.181.226.74"
}

# arcticfox
resource "cloudns_dns_record" "doridian_net_arcticfox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "arcticfox"
  ttl   = 3600
  value = "81.4.122.10"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "arcticfox"
  ttl   = 3600
  value = "2a00:d880:11:0:0:0:0:348"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_mysql" {
  zone = "doridian.net"

  type  = "CNAME"
  name  = "mysql"
  ttl   = 3600
  value = "arcticfox.doridian.net"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_www" {
  zone = "doridian.net"

  type  = "CNAME"
  name  = "www.arcticfox"
  ttl   = 3600
  value = "arcticfox.doridian.net"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_spf" {
  zone = "doridian.net"

  type  = "TXT"
  name  = "arcticfox"
  ttl   = 3600
  value = "v=spf1 +a:arcticfox.doridian.net include:amazonses.com mx ~all"
}

module "arcticfox_ses" {
  source    = "../modules/domain/ses"
  zone      = "doridian.net"
  subdomain = "arcticfox"
}

resource "cloudns_dns_record" "doridian_net_icefox" {
  for_each = toset([
    "dav",
  ])
  zone = "doridian.net"

  type  = "ALIAS"
  name  = each.value
  ttl   = 3600
  value = "icefox.doridian.net"
}

resource "cloudns_dns_record" "doridian_net_mc" {
  zone = "doridian.net"

  type  = "CNAME"
  name  = "mc"
  ttl   = 3600
  value = "minecraft.foxden.network"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_cnames" {
  zone = "doridian.net"

  for_each = toset(["hashtopolis", "www.hashtopolis"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "arcticfox.doridian.net"
}
