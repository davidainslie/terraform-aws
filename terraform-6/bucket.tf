resource "aws_s3_bucket" "terraform-state-aws-s3-bucket" {
  # bucket_prefix = "terraform-state-aws-s3-bucket-"
  bucket = "terraform-state-backwards-aws-s3-bucket"
  # force_destroy = true -- If this state bucket is destroyed during teardown then remote state will "error"

  tags = {
    Name = "terraform-remote-state"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state-aws-s3-bucket-access" {
  bucket = aws_s3_bucket.terraform-state-aws-s3-bucket.id

  # Block public access
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "terraform-state-aws-s3-bucket-versioning" {
  bucket = aws_s3_bucket.terraform-state-aws-s3-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "terraform-state-aws-s3-bucket" {
  value = aws_s3_bucket.terraform-state-aws-s3-bucket.bucket
}