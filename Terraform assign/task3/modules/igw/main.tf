resource "aws_internet_gateway" "igw1" {
  vpc_id = var.vpc_id
  tags   = var.tags
}