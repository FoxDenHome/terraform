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
      source = "Doridian/hexonet"
      version = "~> 0.2"
    }
  }
}