resource "aws_ses_domain_dkim" "ses" {
  domain = local.full_domain
}

resource "constellix_cname_record" "ses_dkim_record" {
  count = 3

  domain_id = var.domain.id

  type        = "CNAME"
  name        = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}._domainkey${local.subdomain_dotstart}"
  ttl         = 3600
  source_type = "domains"

  host = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}.dkim.amazonses.com."
}
