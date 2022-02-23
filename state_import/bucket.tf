resource "aws_s3_bucket" "terraform_state_import" {
    bucket = "levelup-terraform-state-import"
    acl = "private"
    
    tags = local.tags
}