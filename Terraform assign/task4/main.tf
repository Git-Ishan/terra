module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.network_cidr_block
  az_count            = var.zone_count
  availability_zones  = var.zones_list
}

module "networking" {
  source           = "./modules/networking"
  az_count         = var.zone_count
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_tiers
  private_subnets  = module.vpc.private_tiers
  db_subnets       = module.vpc.database_tiers
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "compute" {
  source         = "./modules/compute"
  vpc_id         = module.vpc.vpc_id
  web_subnets    = module.vpc.public_tiers
  app_subnets    = module.vpc.private_tiers
  web_sg         = module.security.web_sg_id
  app_sg         = module.security.app_sg_id
  key_name       = var.ssh_key
  instance_type  = var.vm_type
  ami_id         = var.image_id
  user_data      = var.bootstrap_script
}

module "alb" {
  source           = "./modules/alb"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_tiers
  private_subnets  = module.vpc.private_tiers
  web_sg           = module.security.web_sg_id
  app_sg           = module.security.app_sg_id
  web_target_arn   = module.compute.web_target_group_arn
  app_target_arn   = module.compute.app_target_group_arn
}

module "rds" {
  source        = "./modules/rds"
  db_pass       = var.database_password
  db_subnets    = module.vpc.database_tiers
  db_sg         = module.security.db_sg_id
}
