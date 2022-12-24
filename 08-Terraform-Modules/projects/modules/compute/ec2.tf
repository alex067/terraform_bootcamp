data "aws_ami" "aws_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "serverA" {
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.small"
  associate_public_ip_address = false
  ebs_optimized               = false
  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.lb_to_ec2.id]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = true
    encrypted             = false
    tags                  = local.tags
  }

  tags = merge(local.tags, {
    Name : "terraform_bootcamp_serverA"
  })
}

resource "aws_instance" "serverB" {
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.small"
  associate_public_ip_address = false
  ebs_optimized               = false
  subnet_id                   = var.private_subnet_ids[1]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = true
    encrypted             = false
    tags                  = local.tags
  }

  tags = merge(local.tags, {
    Name : "terraform_bootcamp_serverB"
  })
}

