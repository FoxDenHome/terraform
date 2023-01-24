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
