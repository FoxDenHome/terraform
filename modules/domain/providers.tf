terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
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
      version = "~> 0.17"
    }

    inwx = {
      source  = "inwx/inwx"
      version = "~> 1.0"
    }
  }
}
