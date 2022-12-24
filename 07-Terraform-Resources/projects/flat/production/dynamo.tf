resource "aws_dynamodb_table" "random" {
  name         = "TerraformBootcampRandomTable-${local.env}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "RandomId"

  attribute {
    name = "RandomId"
    type = "S"
  }

  tags = merge(local.tags, {
    Name = "TerraformBootcampRandomTable-${local.env}"
  })
}