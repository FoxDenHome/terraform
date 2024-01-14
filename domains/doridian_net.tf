resource "cloudns_dns_record" "doridian_net_wan" {
  zone     = "doridian.net"
  for_each = toset(["www.spaceage", "spaceage", "api.spaceage", "tts.spaceage"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "wan.foxden.network"
}

# icefox
resource "cloudns_dns_record" "doridian_net_icefox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "icefox"
  ttl   = 3600
  value = "107.181.226.74"
}

resource "cloudns_dns_record" "doridian_net_jellyfin_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "jellyfin"
  ttl   = 3600
  value = "107.181.226.75"
}

resource "cloudns_dns_record" "doridian_net_syncthing_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "syncthing"
  ttl   = 3600
  value = "107.181.226.76"
}

# redfox
resource "cloudns_dns_record" "doridian_net_redfox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "redfox"
  ttl   = 3600
  value = "144.202.81.146"
}

# arcticfox
resource "cloudns_dns_record" "doridian_net_arcticfox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "arcticfox"
  ttl   = 3600
  value = "107.189.10.224"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "arcticfox"
  ttl   = 3600
  value = "2605:6400:30:fcce:1337:1337:1337:1337"
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

resource "cloudns_dns_record" "doridian_net_mc" {
  zone = "doridian.net"

  type  = "CNAME"
  name  = "mc"
  ttl   = 3600
  value = "minecraft.foxden.network"
}
