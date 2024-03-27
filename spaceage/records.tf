resource "cloudns_dns_record" "main_records" {
  zone     = "spaceage.mp"
  for_each = toset(["api", "tts"])

  type  = "CNAME"
  name  = each.value
  ttl   = 3600
  value = "spaceage.mp"
}
