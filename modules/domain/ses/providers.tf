terraform {
  required_providers {
    cloudns = {
      source  = "mangadex-pub/cloudns"
      version = "0.3.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
