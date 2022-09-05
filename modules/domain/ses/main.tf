terraform {
  required_providers {
    constellix = {
      source  = "Constellix/constellix"
      version = "~> 0.4"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  subdomain_dotend   = (var.subdomain == "") ? "" : "${var.subdomain}."
  subdomain_dotstart = (var.subdomain == "") ? "" : ".${var.subdomain}"
  full_domain        = "${local.subdomain_dotend}${var.domain.name}"
}

resource "aws_ses_domain_identity" "ses" {
  domain = local.full_domain
}
