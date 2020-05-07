provider "aws" {
  region="eu-west-1"
  access_key = var.my-access-key
  secret_key = var.my-secret-key
  skip_credentials_validation = true
  version = "~> 2.0"
}
terraform {
  required_version = ">= 0.12, < 0.13"
}


resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

