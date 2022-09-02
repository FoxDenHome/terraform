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
  basiczones = {
    "candy-girl.net" = {
      fastmail             = false,
      ses                  = true,
      add_root_aname       = false,
      redirect_www_to_root = false,
      add_www_cname        = false,
      transfer_lock        = true,
    },
    "zoofaeth.de" = {
      fastmail             = false,
      ses                  = true,
      add_root_aname       = false,
      redirect_www_to_root = false,
      add_www_cname        = false,
      transfer_lock        = false,
    },
  }
}
module "records" {
  for_each = local.basiczones
  source   = "./records"

  domain = module.basiczone[each.key].domain
}

module "basiczone" {
  source = "../modules/basiczone"

  for_each = local.basiczones

  main_domain = var.server_domain
  domain      = each.key

  fastmail             = each.value.fastmail
  ses                  = each.value.ses
  add_root_aname       = each.value.add_root_aname
  redirect_www_to_root = each.value.redirect_www_to_root
  add_www_cname        = each.value.add_www_cname
  transfer_lock        = each.value.transfer_lock
}
