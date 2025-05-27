resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_subnet" "public" {
  count                   = var.az_count
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Tier = "Web" })
}

resource "aws_subnet" "private_app" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.az_count)
  availability_zone = element(var.availability_zones, count.index)
  tags              = merge(var.tags, { Tier = "App" })
}

resource "aws_subnet" "private_db" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + (2 * var.az_count))
  availability_zone = element(var.availability_zones, count.index)
  tags              = merge(var.tags, { Tier = "Database" })
}
