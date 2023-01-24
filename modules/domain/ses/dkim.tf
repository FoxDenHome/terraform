resource "aws_ses_domain_dkim" "ses" {
  domain = local.full_domain
}

resource "cloudflare_record" "ses_dkim_record" {
  count = 3

  zone_id = var.zone.id

  type  = "CNAME"
  name  = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}._domainkey${local.subdomain_dotstart}"
  ttl   = 3600
  value = "${aws_ses_domain_dkim.ses.dkim_tokens[count.index]}.dkim.amazonses.com."
}
