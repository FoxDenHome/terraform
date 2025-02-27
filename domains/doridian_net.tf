# icefox

resource "cloudns_dns_record" "doridian_net_icefox_a" {
  zone     = "doridian.net"

  type  = "A"
  name  = "icefox"
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "doridian_net_icefox_aaaa" {
  zone     = "doridian.net"

  type  = "AAAA"
  name  = "icefox"
  ttl   = 3600
  value = "2a01:4f9:3b:4960::2"
}

resource "cloudns_dns_record" "doridian_net_icefox_ext_a" {
  zone     = "doridian.net"

  type  = "A"
  name  = "icefox-ext"
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "doridian_net_icefox_ext_aaaa" {
  zone     = "doridian.net"

  type  = "AAAA"
  name  = "icefox-ext"
  ttl   = 3600
  value = "2a01:4f9:3b:4960::2"
}

resource "cloudns_dns_record" "doridian_net_restic_a" {
  zone     = "doridian.net"

  type  = "A"
  name  = "restic"
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "doridian_net_restic_aaaa" {
  zone     = "doridian.net"

  type  = "AAAA"
  name  = "restic"
  ttl   = 3600
  value = "2a01:4f9:3b:4960::7"
}

resource "cloudns_dns_record" "doridian_net_syncthing_a" {
  zone     = "doridian.net"

  type  = "A"
  name  = "syncthing"
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "doridian_net_syncthing_aaaa" {
  zone     = "doridian.net"

  type  = "AAAA"
  name  = "syncthing"
  ttl   = 3600
  value = "2a01:4f9:3b:4960::6"
}

resource "cloudns_dns_record" "doridian_net_archlinux_a" {
  zone = "doridian.net"

  type  = "A"
  name  = "archlinux"
  ttl   = 3600
  value = "65.21.120.225"
}

resource "cloudns_dns_record" "doridian_net_archlinux_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "archlinux"
  ttl   = 3600
  value = "2a01:4f9:3b:4960::3"
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
  value = "65.21.120.223"
}

resource "cloudns_dns_record" "doridian_net_arcticfox_aaaa" {
  zone = "doridian.net"

  type  = "AAAA"
  name  = "arcticfox"
  ttl   = 3600
  value = "2a01:4f9:3b:4960:1::2"
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

resource "cloudns_dns_record" "doridian_net_atproto" {
  zone = "doridian.net"

  type  = "TXT"
  name  = "_atproto"
  ttl   = 3600
  value = "did=did:plc:cvicss3pgv6r4qhk3nzrb543"
}
