terraform {
  backend "s3" {
    bucket  = "myterraformudemybootcamp" // Put your bucket info here
    key     = "06terraformstate/flat/prod/terraform.tfstate"
    region  = "us-west-2"
    profile = "terraform_bootcamp"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
  required_version = "~> 1.2.4"
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "terraform_bootcamp"
}