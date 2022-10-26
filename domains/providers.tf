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
      version = "~> 0.15"
    }

    inwx = {
      source  = "inwx/inwx"
      version = "~> 1.0"
    }
  }

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "domains.tfstate"
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

provider "inwx" {
  username = var.inwx_username
  password = var.inwx_password
}
