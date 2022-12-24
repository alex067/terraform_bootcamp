locals {
  random_lambda_name = "terraform_bootcamp_random_lambda-${local.env}"
}

data "aws_iam_policy_document" "random" {
  statement {
    actions = [
      "dynamodb:*"
    ]

    resources = [
      aws_dynamodb_table.random.arn
    ]
  }
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.main.arn
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.random.arn}:*"
    ]
  }
}

resource "aws_iam_role" "random" {
  name = "${local.random_lambda_name}_role"

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

resource "aws_iam_policy" "random" {
  name   = "${local.random_lambda_name}_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.random.json
}

resource "aws_iam_role_policy_attachment" "random" {
  role       = aws_iam_role.random.name
  policy_arn = aws_iam_policy.random.arn
}

resource "aws_lambda_function" "random" {
  function_name = local.random_lambda_name
  s3_bucket     = aws_s3_bucket.main.id
  s3_key        = "lambda_artifact.zip"
  role          = aws_iam_role.random.arn
  handler       = "app.handler"
  runtime       = "python3.8"
  memory_size   = 256
  timeout       = 10

  environment {
    variables = {
      DYNAMO_TABLE_NAME = aws_dynamodb_table.random.id
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.random,
    aws_s3_bucket_object.main
  ]

  tags = merge(local.tags, {
    Name = local.random_lambda_name
  })
}

resource "aws_cloudwatch_log_group" "random" {
  name              = "/aws/lambda/${local.random_lambda_name}"
  retention_in_days = 14
}

resource "aws_lambda_permission" "api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.random.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
}