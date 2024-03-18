/*
  Shared AMI for bastion and app server
*/

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

/*
  Application Instance
*/

resource "random_shuffle" "private_subnets" {
  input = var.private_subnet_ids
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.nano"
  subnet_id              = random_shuffle.private_subnets.result[0]
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name               = var.key_name
  user_data              = <<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y 
    sudo service nginx start
    world
  EOT

  tags = {
    Name = "${var.name}-app"
  }
}

/*
  Bastion Instance
*/

resource "random_shuffle" "public_subnets" {
  input = var.public_subnet_ids
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.nano"
  subnet_id                   = random_shuffle.public_subnets.result[0]
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = "${var.name}-bastion"
  }
}
