resource "aws_vpc" "production-vpc" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true

  tags = {
    Name = "production-vpc"
  }
}