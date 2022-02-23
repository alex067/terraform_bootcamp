output "private_ip" {
  value     = aws_instance.main.*.private_ip
  sensitive = true
}