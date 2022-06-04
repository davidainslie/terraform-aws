resource "tls_private_key" "private-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key-pair" {
  key_name = "key-pair"
  public_key = tls_private_key.private-key.public_key_openssh
}

resource "local_file" "pem-file" {
  filename = pathexpand("./${aws_key_pair.key-pair.key_name}.pem")
  file_permission = "600"
  content = tls_private_key.private-key.private_key_pem
}

output "key-pair-generated" {
  value = aws_key_pair.key-pair.key_name
}

/*
resource "null_resource" "ssh-command" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo SSH = ssh -i ${local_file.pem-file.filename} ec2-user@${aws_instance.free-scala-ec2.public_ip}
    EOT
  }
}*/
