
resource "aws_ses_domain_identity" "ses" {
  count  = var.ses ? 1 : 0
  domain = var.domain
}

resource "constellix_txt_record" "ses_verification_record" {
  count     = var.ses ? 1 : 0
  domain_id = constellix_domain.domain.id

  type        = "TXT"
  name        = "_amazonses"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = aws_ses_domain_identity.ses[0].verification_token
  }
}

resource "aws_ses_domain_dkim" "ses" {
  count  = var.ses ? 1 : 0
  domain = var.domain
}

resource "constellix_cname_record" "ses_dkim_record" {
  count = var.ses ? 3 : 0

  domain_id = constellix_domain.domain.id

  type        = "CNAME"
  name        = "${aws_ses_domain_dkim.ses[0].dkim_tokens[count.index]}._domainkey"
  ttl         = 3600
  source_type = "domains"

  host = "${aws_ses_domain_dkim.ses[0].dkim_tokens[count.index]}.dkim.amazonses.com."
}
