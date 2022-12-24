resource "aws_subnet" "private" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if subnet.is_public == false }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(local.tags, {
    Name = "${var.vpc_id}_subnet_${each.value.name}"
  })
}

resource "aws_subnet" "public" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if subnet.is_public == true }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(local.tags, {
    Name = "${var.vpc_id}_subnet_${each.value.name}"
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = var.public_route_table_id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = var.private_route_table_id
}