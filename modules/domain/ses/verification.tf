resource "constellix_txt_record" "ses_verification_record" {
  domain_id = var.domain.id

  type        = "TXT"
  name        = "_amazonses${local.subdomain_dotstart}"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = aws_ses_domain_identity.ses.verification_token
  }
}
