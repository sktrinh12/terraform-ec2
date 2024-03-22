# terraform-ec2

Run command:

```
terraform plan -var-file=tfvars/${VARS_FILE}.tfvars

terraform apply -var-file=tfvars/${VARS_FILE}.tfvars -auto-approve

terraform destroy -var-file=tfvars/${VARS_FILE}.tfvars -auto-approve

```

The output will be the ips of the ec2 instances. A `inventory.ini` file is
generated for ansible to leverage in order to configure the ec2 instances.
