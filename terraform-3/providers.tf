terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
}

provider "aws" {
  /*
  Not required as we are using cloud state (with Terraform Cloud) instead of local state
  access_key  = var.aws-access-key-id
  secret_key  = var.aws-secret-access-key
  */
  region = var.aws-region
}