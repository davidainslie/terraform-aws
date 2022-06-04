output "my-ec2-id" {
  value = aws_instance.my-ec2.id
}

output "my-ec2-dns" {
  value = aws_instance.my-ec2.public_dns
}

output "my-ec2-ip" {
  value = aws_instance.my-ec2.public_ip
}