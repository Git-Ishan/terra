resource "aws_s3_bucket" "b1" {
  bucket = var.bucket_name

  tags = var.tags
}