terraform {
  required_version = ">= 0.12, < 0.13"
}

terraform{
  backend "s3"{
    bucket = "terra-state-bucket-app-ym"
    key = "s3/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terra-state-db-app-ym"
    encrypt = true 

  }
}
provider "aws" {
  region="eu-west-1"
  access_key = "add your access key"
  secret_key = "add your secret"
  skip_credentials_validation = true
  version = "~> 2.0"
}

resource "aws_s3_bucket" "terraform_state" {

  bucket = var.bucket_name
  force_destroy = true
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  username            = "admin"
  name                = "terra_state_db_app_ym"
  skip_final_snapshot = true
  password            = "admin123"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terra-state-db-app-ym"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
