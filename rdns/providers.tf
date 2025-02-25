terraform {
  required_providers {
    cloudns = {
      source  = "mangadex-pub/cloudns"
      version = "~> 0.4"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.2"
    }

    hexonet = {
      source  = "Doridian/hexonet"
      version = "~> 0.20"
    }
  }

  backend "s3" {
    bucket = "foxden-tfstate"
    region = "eu-north-1"
    key    = "rdns.tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "hexonet" {
  allow_domain_create_delete = false
}
