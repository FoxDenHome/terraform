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

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "familydomains.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "constellix" {
  insecure  = false
  apikey    = var.constellix_apikey
  secretkey = var.constellix_secretkey
}

locals {
  domains = {
    "candy-girl.net" = {
      fastmail             = false,
      ses                  = true,
      redirect_www_to_root = false,
      add_www_cname        = false,
      transfer_lock        = true,
    },
    "zoofaeth.de" = {
      fastmail             = false,
      ses                  = true,
      redirect_www_to_root = false,
      add_www_cname        = false,
      transfer_lock        = false,
    },
  }
}
module "records" {
  for_each = local.domains
  source   = "./records"

  domain = module.domain[each.key].domain
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  root_aname           = var.server_domain
  fastmail             = each.value.fastmail
  ses                  = each.value.ses
  redirect_www_to_root = each.value.redirect_www_to_root
  add_www_cname        = each.value.add_www_cname
  transfer_lock        = each.value.transfer_lock
}
