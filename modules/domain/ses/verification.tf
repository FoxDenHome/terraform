resource "cloudflare_record" "ses_verification_record" {
  zone_id = var.zone.id

  type  = "TXT"
  name  = "_amazonses${local.subdomain_dotstart}"
  ttl   = 3600
  value = aws_ses_domain_identity.ses.verification_token
}
