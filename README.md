# terraform-ec2

Run command:

```
terraform plan -var-file=tfvars/${VARS_FILE}.tfvars

terraform apply -var-file=tfvars/${VARS_FILE}.tfvars -auto-approve

terraform destroy -var-file=tfvars/${VARS_FILE}.tfvars -auto-approve

```

The output will be the ips of the ec2 instances. A `inventory.ini` file is
generated for ansible to leverage in order to configure the ec2 instances.

Ensure a tfvars directory exists in the project directory and contains a
`.tfvars` file which contains something like:

```
ami           = "ami-123456789"
instance_type = "t2.micro"
key_name      = "name_ec2_key"
number_of_instances = 1
name = "name"
ingress_cidr = ["0.0.0.0/24"]
account_id = "123456789"
```
