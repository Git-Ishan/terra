output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eip" {
  value = module.eip.public_ip
}

output "instance_id" {
  value = module.ec2.instance_id
}