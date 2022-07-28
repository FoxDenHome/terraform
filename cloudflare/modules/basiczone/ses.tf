resource "aws_ses_domain_identity" "ses" {
  count = var.ses ? 1 : 0

  domain = var.domain
}

resource "cloudflare_record" "ses_verification_record" {
  count = var.ses ? 1 : 0

  allow_overwrite = true
  zone_id         = cloudflare_zone.zone.id

  type    = "TXT"
  name    = "_amazonses"
  proxied = false
  value   = aws_ses_domain_identity.ses[0].verification_token
}
