/*
terraform init

Local:
---------
terraform apply -var-file="secrets.tfvars"
terraform destroy -var-file="secrets.tfvars"

Cloud (remote):
------------------
terraform login <--- redirected to browser to generate token (if you don't have one)
Also, make sure to have a cloud workspace set up

In the configs (upon not using local state anymore) we need to add the following AWS credentials environment variables:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

terraform apply
terraform destroy
*/

resource "random_pet" "sg" {}

resource "aws_instance" "my-ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "example-1-an-ec2-instance"
  }
}

# Get the web address (to hit)
output "web-address" {
  value = aws_instance.my-ec2.public_dns
}