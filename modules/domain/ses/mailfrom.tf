locals {
  mail_from_host   = "${var.mail_from_subdomain}${local.subdomain_dotstart}"
  mail_from_domain = "${var.mail_from_subdomain}.${local.full_domain}"
}

data "aws_region" "current" {}

resource "aws_ses_domain_mail_from" "ses_mailfrom" {
  domain           = local.full_domain
  mail_from_domain = local.mail_from_domain
}

resource "constellix_mx_record" "ses_mailfrom" {
  domain_id = var.domain.id

  name        = local.mail_from_host
  type        = "MX"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value        = "feedback-smtp.${data.aws_region.current.name}.amazonses.com."
    level        = 10
    disable_flag = false
  }
}

resource "constellix_txt_record" "ses_mailfrom" {
  domain_id = var.domain.id

  name        = local.mail_from_host
  type        = "TXT"
  ttl         = 3600
  source_type = "domains"

  roundrobin {
    value = "v=spf1 include:amazonses.com -all"
  }
}
