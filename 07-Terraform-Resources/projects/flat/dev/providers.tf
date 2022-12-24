terraform {
  backend "s3" {
    bucket  = "myterraformudemybootcamp" // Put your bucket info here
    key     = "07terraformresource/flat/terraform.tfstate"
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
  region  = "us-west-2"
  profile = "terraform_bootcamp"
}