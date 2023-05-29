terraform {
  required_providers {
    cloudns = {
      source  = "mangadex-pub/cloudns"
      version = "0.2.0"
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
      version = "~> 0.19"
    }
  }
}
