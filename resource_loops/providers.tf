terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.0.4"
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-west-2"
  profile = "levelup_terraform"
}

