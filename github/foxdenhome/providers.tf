terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "github-foxdenhome.tfstate"
  }
}

provider "github" {
  owner = "FoxDenHome"
}
