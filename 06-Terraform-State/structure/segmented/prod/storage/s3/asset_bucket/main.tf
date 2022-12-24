
resource "random_string" "random" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

resource "aws_s3_bucket" "main" {
  bucket = "terraform_bootcamp_${random_string.random.result}"
  acl    = "private"

  tags = {
    name        = "terraform_bootcamp_${random_string.random.result}"
    environment = var.environment
    region      = var.region
  }
}
