locals {
  env    = "dev"
  region = "us-west-2"
  tags = {
    course = "terraform_bootcamp"
    env    = local.env
    region = "us-west-2"
  }
}