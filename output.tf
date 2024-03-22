output "ec2_instance_ips" {
  value = [for instance in module.ec2_instances : instance.public_ip]
}
