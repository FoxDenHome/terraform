terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "foxden-tfstate"
    region = "eu-north-1"
    key    = "github-foxcaves.tfstate"
  }
}

provider "github" {
  owner = "foxCaves"
}
