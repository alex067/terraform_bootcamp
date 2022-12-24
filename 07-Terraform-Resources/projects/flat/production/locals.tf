locals {
  env    = "prod"
  region = "us-east-1"
  tags = {
    course = "terraform_bootcamp"
    env    = local.env
    region = "us-east-1"
  }
}