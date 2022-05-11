terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cuvmit"

    workspaces {
      name = "actions"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

