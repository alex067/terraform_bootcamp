data "terraform_remote_state" "asset_bucket" {
  backend = "s3"
  config = {
    bucket  = "myterraformudemybootcamp" // Put your bucket info here
    key     = "06terraformstate/segmented/storage/s3/asset_bucket/terraform.tfstate"
    region  = "us-west-2"
    profile = "terraform_bootcamp"
  }
}

data "aws_iam_policy_document" "instance_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "main" {
  name = "terraform_segmented_dev_policy"
  role = aws_iam_role.main.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = [data.terraform_remote_state.asset_bucket.outputs.arn]
      },
    ]
  })
}

resource "aws_iam_role" "main" {
  name               = "terraform_segmented_state_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume.json
}