variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "terra-state-bucket-app-ym"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "terra-state-db-app-ym"
}

variable "my-access-key" {
    type= string
}            
variable "my-secret-key" {
    type = string
}
/*
variable "ami" {
  type=string
  default = "ami-0dad359ff462124ca"
}
variable "region" {
  type = string
  default="eu-west-1"
}*/
