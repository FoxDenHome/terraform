# icefox
resource "cloudns_dns_record" "doridian_net_icefox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "icefox"
  ttl   = 3600
  value = "23.239.97.10"
}

resource "cloudns_dns_record" "doridian_net_icefox_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "icefox"
  ttl   = 3600
  value = "2606:c700:4020:af::2"
}

resource "cloudns_dns_record" "doridian_net_dav_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "dav"
  ttl   = 3600
  value = "23.239.97.10"
}

resource "cloudns_dns_record" "doridian_net_dav_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "dav"
  ttl   = 3600
  value = "2606:c700:4020:af::2"
}

resource "cloudns_dns_record" "doridian_net_jellyfin_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "jellyfin"
  ttl   = 3600
  value = "23.239.97.11"
}

resource "cloudns_dns_record" "doridian_net_jellyfin_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "icefox"
  ttl   = 3600
  value = "2606:c700:4020:af::3"
}

resource "cloudns_dns_record" "doridian_net_syncthing_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "syncthing"
  ttl   = 3600
  value = "23.239.97.12"
}

resource "cloudns_dns_record" "doridian_net_syncthing_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "syncthing"
  ttl   = 3600
  value = "2606:c700:4020:af::4"
}

# redfox
resource "cloudns_dns_record" "doridian_net_redfox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "redfox"
  ttl   = 3600
  value = "144.202.81.146"
}

resource "cloudns_dns_record" "doridian_net_redfox_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "redfox"
  ttl   = 3600
  value = "2001:19f0:8001:f07:5400:4ff:feb1:d2e3"
}

# arcticfox
resource "cloudns_dns_record" "doridian_net_arcticfox_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "arcticfox"
  ttl   = 3600
  value = "23.239.97.14"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_aaaa" {
 zone = "doridian.net"

 type  = "AAAA"
 name  = "arcticfox"
 ttl   = 3600
 value = "2606:c700:4020:af::6"
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

resource "cloudns_dns_record" "doridian_net_arcticfox_dmarc" {
  zone = "doridian.net"

  name  = "_dmarc.arcticfox"
  type  = "TXT"
  ttl   = 3600
  value = "v=DMARC1;p=quarantine;pct=100"
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
