terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "cloudflare-family"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "records" {
  for_each = var.basiczones
  source   = "./records"

  zone = module.basiczone[each.key].zone
}

module "basiczone" {
  source = "../modules/basiczone"

  for_each = var.basiczones

  account_id  = var.account_id
  main_domain = var.server_domain
  domain      = each.key

  fastmail             = false
  ses                  = true
  redirect_all_to_main = false
  redirect_www_to_root = false
  add_www_cname        = false
}
