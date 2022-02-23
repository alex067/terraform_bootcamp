resource "aws_s3_bucket" "terraform_state" {
    bucket = "levelup-terraform"
    acl = "private"
    
    tags = local.tags
}