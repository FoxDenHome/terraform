resource "aws_ses_domain_identity" "ses" {
  domain = var.domain.name
}

resource "constellix_txt_record" "ses_verification_record" {
  domain_id = var.domain.id

  type        = "TXT"
  name        = "_amazonses"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = aws_ses_domain_identity.ses.verification_token
  }
}

resource "aws_ses_domain_dkim" "ses" {
  domain = var.domain.name
}

resource "constellix_cname_record" "ses_dkim_record" {
  count = 3

  domain_id = var.domain.id

  type        = "CNAME"
  name        = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}._domainkey"
  ttl         = 3600
  source_type = "domains"

  host = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}.dkim.amazonses.com."
}
