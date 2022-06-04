/*
---------------------------------------------------------------------------------------
Cloud (remote):

terraform login <--- redirected to browser to generate token (if you don't have one).

terraform init <--- if this does not automatically create your Terraform Cloud workspace, then add it (in this case aws-demo).

In the configs (upon not using local state anymore) we need to add the following AWS credentials environment variables,
i.e. in Terraform Cloud go to Settings > Add (environment) variable:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

terraform apply
terraform destroy

---------------------------------------------------------------------------------------
terraform state list
data.aws_ami.ubuntu
aws_instance.my-ec2
random_pet.sg

---------------------------------------------------------------------------------------
terraform output
my-ec2-dns = "ec2-54-89-141-192.compute-1.amazonaws.com"
my-ec2-id = "i-03b96de2ba4885381"
my-ec2-ip = "54.89.141.192"

---------------------------------------------------------------------------------------
Terraform Cloud portal (Overview tab) will show these stats.
*/

resource "random_pet" "sg" {}

resource "aws_instance" "my-ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "example-1-an-ec2-instance"
  }
}