### Demonstrates the ignore_changes lifecycle

resource "aws_iam_role" "lambda_assume" {
  name = "lambda_assume"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_lambda_function" "main_ignore_changes" {
  filename      = "lambda.zip"
  function_name = "levelup_terraform_lambda"
  role          = aws_iam_role.lambda_assume.arn
  handler       = "app.handler"
  runtime       = "python3.8"

  environment {
    variables = {
      foo = "bar"
    }
  }

  # Ignores changes made to environment and tags
  # Resource still can get created but ignores updates on provided attributes
  lifecycle {
    ignore_changes = [
      environment,
      tags
    ]
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform"
  })
}