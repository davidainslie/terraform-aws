/*
Initially comment out backend "s3" {} in providers.tf
terraform init

terraform apply -var-file="secrets.tfvars"

After infrastructure config is generated, enable backend "s3" {} in providers.tf
And delete terraform.tfstate
terraform init -backend-config=infrastructure/infrastructure-prod.config

And again
terraform apply -var-file="secrets.tfvars"

terraform destroy -var-file="secrets.tfvars"

terraform state list

terraform output
*/

resource "local_file" "infrastructure-prod-config" {
  filename = "infrastructure/infrastructure-prod.config"
  content = <<-EOT
    region = "${var.aws-region}"
    key = "layer1/infrastructure.tfstate"
    bucket = "${aws_s3_bucket.terraform-state-aws-s3-bucket.bucket}"
    access_key = "${var.aws-access-key-id}"
    secret_key = "${var.aws-secret-access-key}"
  EOT
}