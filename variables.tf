variable "ami"           {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "number_of_instances" {
  type = number
}

variable "name" {
  description = "name of client"
  type        = string
}

variable "ingress_cidr" {
  description = "ingress cidr block ip address range"
  type = list
}

variable "account_id" {
  description = "aws account id"
  type = string
}
