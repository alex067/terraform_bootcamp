resource "aws_s3_bucket" "main" {
    bucket = "levelup-terraform-modules-workshop-${var.env}"
    
    acl = "private"
    tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}