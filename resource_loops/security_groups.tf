resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inboud traffic"

  tags = merge(local.tags, {
    Name = "levelup_with_terraform-sg"
  })
}

resource "aws_security_group_rule" "ingress_allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id
  description       = "SSH from home"

  type             = "ingress"
  from_port        = "22"
  to_port          = "22"
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}