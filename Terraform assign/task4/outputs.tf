output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  value       = module.vpc.private_subnets
}

output "db_subnets" {
  value       = module.vpc.db_subnets
}

output "web_alb_dns_name" {
  value       = module.alb.web_alb_dns_name
}

output "app_alb_dns_name" {
  value       = module.alb.app_alb_dns_name
}

output "rds_endpoint" {
  value       = module.rds.rds_endpoint
  sensitive   = true
}
