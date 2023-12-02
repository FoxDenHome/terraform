resource "cloudns_dns_record" "f0x_es_c0de" {
  zone = "f0x.es"

  type  = "CNAME"
  name  = "c0de"
  ttl   = 3600
  value = "c0defox.es"
}
