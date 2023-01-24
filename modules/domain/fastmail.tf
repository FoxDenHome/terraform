resource "cloudflare_record" "smtp" {
  for_each = var.fastmail ? {
    "in1-smtp.messagingengine.com." : 10,
    "in2-smtp.messagingengine.com." : 20,
  } : {}
  zone_id = cloudflare_zone.zone.id

  name = "@"
  type = "MX"
  ttl  = 3600

  value    = each.key
  priority = each.value
}

resource "cloudflare_record" "dkim" {
  count   = var.fastmail ? 3 : 0
  zone_id = cloudflare_zone.zone.id

  name  = "fm${count.index + 1}._domainkey"
  type  = "CNAME"
  ttl   = 3600
  value = "fm${count.index + 1}.${var.domain}.dkim.fmhosted.com."
}
