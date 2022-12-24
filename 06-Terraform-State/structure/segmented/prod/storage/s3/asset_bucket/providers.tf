terraform {
  backend "s3" {
    bucket  = "myterraformudemybootcamp" // Put your bucket info here
    key     = "06terraformstate/segmented/prod/storage/s3/asset_bucket/terraform.tfstate"
    region  = "us-west-2"
    profile = "terraform_bootcamp"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = "~> 1.2.4"
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "terraform_bootcamp"
}