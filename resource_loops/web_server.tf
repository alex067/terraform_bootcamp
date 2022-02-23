data "aws_ami" "aws_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

# Creating batches using count
resource "aws_instance" "batches_with_count" {  
  count = length(var.batch_workers_set)
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.small"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "2"
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform-instance"
    service : var.batch_workers_set[count.index]
    index : count.index
    type : "batches_with_count"
  })
}

# Creating batches using a set
resource "aws_instance" "batches_with_set" {  
  for_each = toset(var.batch_workers_set)
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = "t3.small"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "2"
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform-instance"
    service : each.key
     type : "batches_with_set"
  })
}

# Creating batches with foreach loop
resource "aws_instance" "batches_with_foreach" {  
  for_each = var.batch_workers_obj
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = each.value
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "2"
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform-instance"
    service : each.key
    type : "batches_with_foreach"
  })
}

# Creating batches from a nested object
resource "aws_instance" "batches_with_nested" {  
  for_each = var.batch_workers_nested
  ami = data.aws_ami.aws_linux_2.id

  instance_type               = each.value.instance_type
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "2"
  }

  tags = merge(local.tags, {
    Name : "levelup_with_terraform-instance"
    service : each.value.name
    type : "batches_with_nested"
    key : each.key
  })
}