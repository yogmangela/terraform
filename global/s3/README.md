# S3 Remote State Example

Configure your [AWS access 
keys](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) as 
environment variables:

```
export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
```

Specify a name for the S3 bucket and DynamoDB table in `variables.tf` using the `default` parameter:

```hcl
variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "<YOUR BUCKET NAME>"
}

variable "table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "<YOUR TABLE NAME>"
}
```

Deploy the code:

```
cd s3
terraform init
terraform apply
```

once you have run ``terraform apply`` after few minutes it should creat mySQL db
check under RDS.
```
  Enter a value: yes

aws_db_instance.example: Creating...
aws_db_instance.example: Still creating... [10s elapsed]
aws_db_instance.example: Still creating... [2m10s elapsed]
.
.
.
aws_db_instance.example: Still creating... [3m50s elapsed]
aws_db_instance.example: Creation complete after 3m53s [id=terraform-up-and-running20200511115833830300000001]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

dynamodb_table_name = terra-state-db-app-ym
s3_bucket_arn = arn:aws:s3:::terra-state-bucket-app
```
**How to use s3 module**
```
provider "aws" {
  region="eu-west-1"
  version = "~> 2.0"
}

module "my-s3" {
    source = "github.com/yogmangela/terraform//global/s3"
    my-access-key = "Add your access key"
    my-secret-key = "add your secrete key"
}

```

- this will download module under >>`` .terraform>>modules>>my-s3>>global\s3 ``


Clean up when you're done:

```
terraform destroy
```
