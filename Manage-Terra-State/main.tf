provider "aws" {
  region="eu-west-1"
  access_key = var.my-access-key
  secret_key = var.my-secret-key
  version = "~> 2.0"
}
terraform {
  required_version = ">= 0.12, < 0.13"
}

//========================================================================

resource "aws_instance" "example" {
  ami                    = "ami-0dad359ff462124ca"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}


/**
provider "aws" {
  region="eu-west-1"
 // access_key = "AKIAWBOUEDMK73RBRAPG"
  //secret_key = "pEFfhzluRsqxbrW/6yUeCX7t2cZ2cmPSbWJBwvsh"
}

resource "aws_s3_bucker" "terraform_state" {
  bucket= "terraform-up-and-running-state"
  lifecycle{
    prevent_destroy=true
  }

  versioning{
    enabled=true
  }

  server_side_encryption-configuration{
    rule{
      apply_server_side_encryption_by_default{
        sse_algorithm="AES256"
      }
    }
  }
}


resource "aws_dynamodb_table" "terraform-locks" {
  name  ="terraform-uo-and-running-locks"
  billing_mode="PAY_PER_REQUEST"
  hash_key="LockID"

  attribute{
    name="LockID"
    type="S"
  }
}


terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table       = "terraform-uo-and-running-locks"
    encrypt        = true

  }
}
*/