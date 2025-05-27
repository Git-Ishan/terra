
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_eip" "nat" {
  count = var.az_count
  domain = "vpc"
  tags   = merge(var.tags, { Name = "nat-eip-${count.index + 1}" })
}

resource "aws_nat_gateway" "this" {
  count         = var.az_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.public_subnets[count.index]
  tags          = merge(var.tags, { Name = "nat-gw-${count.index + 1}" })
  depends_on    = [aws_internet_gateway.this]
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = merge(var.tags, { Name = "public-rt" })
}

resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }
  tags = merge(var.tags, { Name = "private-rt-${count.index + 1}" })
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_app" {
  count          = var.az_count
  subnet_id      = var.private_subnets[count.index]
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "private_db" {
  count          = var.az_count
  subnet_id      = var.db_subnets[count.index]
  route_table_id = aws_route_table.private[count.index].id
}
