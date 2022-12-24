resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, {
    Name = "${var.env}_vpc"
  })
}

resource "aws_internet_gateway" "main" {
  count  = var.enable_igw ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${var.env}_IGW"
  })
}