resource "aws_ses_domain_identity" "ses" {
  domain = var.zone.zone
}

resource "cloudflare_record" "ses_verification_record" {
  allow_overwrite = true
  zone_id         = var.zone.id

  type    = "TXT"
  name    = "_amazonses"
  value   = aws_ses_domain_identity.ses.verification_token
  proxied = false
}

resource "aws_ses_domain_dkim" "ses" {
  domain = var.zone.zone
}

resource "cloudflare_record" "ses_dkim_record" {
  count = 3

  allow_overwrite = true
  zone_id = var.zone.id

  type = "CNAME"
  name = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}._domainkey"
  value = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}.dkim.amazonses.com"
  proxied = false
}
