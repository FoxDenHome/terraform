terraform {
  required_providers {
    constellix = {
      source  = "Constellix/constellix"
      version = "0.4.5"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "spaceage-production"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "constellix" {
  insecure  = false
  apikey    = var.apikey
  secretkey = var.secretkey
}
