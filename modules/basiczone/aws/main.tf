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
}
