resource "aws_eip" "eip1" {
  domain        = "vpc"
  tags = var.tags
}