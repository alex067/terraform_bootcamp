data "aws_ami" "aws_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "main" {
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.small"
  associate_public_ip_address = true
  ebs_optimized               = false
  iam_instance_profile        = aws_iam_instance_profile.main.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "8"
    delete_on_termination = true
    encrypted             = false
    tags                  = local.tags
  }

  tags = merge(local.tags, {
    Name: "terraform_bootcamp_instance"
  })
}

resource "aws_iam_instance_profile" "main" {
  name = "terraform_bootcamp_profile"
  role = aws_iam_role.main.name
}