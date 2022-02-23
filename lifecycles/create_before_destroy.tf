resource "aws_instance" "main_create_before_destroy" {
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.micro"
  # Change to true after creation, to see lifecycle in action
  associate_public_ip_address = true

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp3"
    volume_size = "2"
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform"
  })

  lifecycle {
    create_before_destroy = true
  }
}