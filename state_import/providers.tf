terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  # Uncomment after adding backend resources! 
  # Then, run terraform init to perform state migration
  backend "s3" {
    bucket = "levelup-terraform"
    key    = "udemy/state_import/terraform.tfstate"
    region = "us-west-2"
    profile = "levelup_terraform"
  }

  required_version = "~> 1.0.4"
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-west-2"
  profile = "levelup_terraform"
}

