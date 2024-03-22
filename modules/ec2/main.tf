resource "aws_instance" "ec2_server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "ssh_access" {
  name = "ssh_access_sg"
  description = "Security group allowing SSH access and app traffic"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.ingress_cidr
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3001
    to_port = 3001
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
