output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "igw_id" {
  value = var.enable_igw ? aws_internet_gateway.main[0].id : null
}

output "public_route_table_id" {
  value = var.enable_igw ? aws_route_table.public[0].id : null
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}