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

    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.2"
    }

    hexonet = {
      source  = "Doridian/hexonet"
      version = "~> 0.12"
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

provider "hexonet" {
  allow_domain_create_delete = false
}