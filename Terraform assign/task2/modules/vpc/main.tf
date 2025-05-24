resource "aws_vpc" "vpc1" {
  cidr_block           = var.cidr_block
 
  tags = {
    Name = var.vpc_name
  }
}