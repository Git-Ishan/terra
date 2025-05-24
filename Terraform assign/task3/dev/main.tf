module "vpc" {  #declation of vpc module
  source = "../modules/vpc"   
  vpc_cidr = var.vpc_cidr
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-vpc" 
      resource_type = "network"
    }
  )
}

module "subnet" {
  source     = "../modules/subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.cidr_block
  availability_zone     = var.availability_zone
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-subnet"
      resource_type = "network"
    }
  )
}

module "igw" {
  source = "../modules/igw"
  vpc_id = module.vpc.vpc_id
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-igw"
      resource_type = "network"
    }
  )
}

module "nat" {
  source = "../modules/nat"
  subnet_id = module.subnet.subnet_id
  allocation_id = module.eip.allocation_id
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-nat"
      resource_type = "network"
    }
  )
}

module "eip" {
  source = "../modules/eip"
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-eip"
    }
  )
}


module "s3" {
  source      = "../modules/s3"
  bucket_name = "${local.env}-${local.app}-bucket"
  tags        = var.common_tags
}


module "sg" {
  source      = "../modules/sg"
  name        = "${local.env}-${local.app}-sg"
  description = "Security group for ${local.env} environment"
  vpc_id      = module.vpc.vpc_id
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-sg"
    },
  )
}


module "ec2" {
  source            = "../modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  tags = merge(
    var.common_tags,
    {
      Name = "${local.env}-${local.app}-ec2"
      resource_type = "compute"
    }
  )
}