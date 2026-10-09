terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.52.0"
    }
    random = {
  source  = "hashicorp/random"
  version = "3.9.1"
}

  }
  required_version = "1.14.8"
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  access_key = var.acess_key
  default_tags {
    tags = var.tags
  }
}

