terraform {
  required_providers {
    cloudns = {
      source  = "mangadex-pub/cloudns"
      version = "0.2.0"
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
      version = "~> 0.19"
    }
  }

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "rdns.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "hexonet" {
  allow_domain_create_delete = false
}
