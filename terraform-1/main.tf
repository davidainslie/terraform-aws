/*
terraform init

---------------------------------------------------------------------------------------
Local:

terraform apply -var-file="secrets.tfvars"
terraform destroy -var-file="secrets.tfvars"

---------------------------------------------------------------------------------------
terraform state list
data.aws_ami.ubuntu
aws_instance.my-ec2
random_pet.sg

---------------------------------------------------------------------------------------
terraform output
my-ec2-dns = "ec2-54-91-187-48.compute-1.amazonaws.com"
my-ec2-id = "i-02a4c2760019f4119"
my-ec2-ip = "54.91.187.48"
*/

resource "random_pet" "sg" {}

resource "aws_instance" "my-ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "example-1-an-ec2-instance"
  }
}