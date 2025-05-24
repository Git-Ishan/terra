# This file is used to configure the backend for Terraform state management.
# It specifies the S3 bucket and key where the Terraform state will be stored and which region the bucket is located.
# this is important for remote state management and collaboration in a team environment.
terraform {
  backend "s3" {
    bucket         = "newbuckfortf"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
  }
}