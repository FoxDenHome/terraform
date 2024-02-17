terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "foxden-terraform"
    region = "us-east-1"
    key    = "github-pawnode.tfstate"
  }
}

provider "github" {
  owner = "PawNode"
}
