terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
      role_arn     = "arn:aws:iam::${var.account_id}:role/TerraformAssumeRole"
      session_name = "TerraformSession"
      external_id       = "tf"
    }

}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.name}_ec2_key"
  public_key = tls_private_key.private_key.public_key_openssh
}


resource "local_file" "private_key_save" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${path.module}/ansible/pems/${var.name}_ec2_key.pem"
  file_permission = "0600"
}

module "ec2_instances" {
  source = "./modules/ec2"

  count    = var.number_of_instances
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  name          = "${var.name}_instance_${count.index+1}"
  ingress_cidr  = var.ingress_cidr
  depends_on    = [aws_key_pair.generated_key]
}

resource "local_file" "ansible_vars" {
  count = length(module.ec2_instances)

  content = templatefile("${path.module}/templates/inventory.tpl", {
    ips = [for k, v in module.ec2_instances : v.public_ip],
    name = "${var.name}_${count.index+1}",
    path = "${path.module}/pems/${var.name}_ec2_key.pem"
  })

  filename = "${path.module}/ansible/${var.name}_inventory.ini"
  directory_permission = "0644"
  file_permission = "0644"
}

