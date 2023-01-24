module "domain" {
  source = "../modules/domain"

  domain = local.main_domain

  fastmail      = true
  ses           = true
  root_aname    = "redfox.doridian.net"
  add_www_cname = true
  vanity_nameserver = {
    list = ["ns1.doridian.net", "ns2.doridian.net", "ns3.doridian.net", "ns4.doridian.net"]
    name = "doridian.net"
  }
  registrar = "dotmp"
}

resource "cloudns_dns_record" "spaceage_mp_redfox" {
  zone = local.main_domain

  for_each = toset(["api", "static", "tts"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "redfox.doridian.net"
}

resource "cloudns_dns_record" "spaceage_mp_local" {
  zone = local.main_domain

  type  = "A"
  name  = "local"
  ttl   = 3600
  value = "127.0.0.1"
}
