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
  }
}
