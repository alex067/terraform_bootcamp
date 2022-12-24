output "private_ip" {
  value = aws_instance.main.private_ip
}

output "tags" {
  value = local.tags
}