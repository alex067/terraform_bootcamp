### Demonstrates the prevent_destroy lifecycle

data "aws_ami" "aws_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "main_prevent_destroy" {
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.micro"
  # Change to true after creation, to see lifecycle in action
  associate_public_ip_address = false

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp3"
    volume_size = "2"
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform"
  })

  lifecycle {
    prevent_destroy = true
  }
}