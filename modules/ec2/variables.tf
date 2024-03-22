variable "ami" {
  description = "The ID of the AMI to use for the EC2 instance"
  type = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type = string
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for SSH access"
  type = string
}

variable "name" {
  description = "The name of the instance"
  type = string
}

variable "ingress_cidr" {
  description = "ingress cidr block ip address range"
  type = list
}
