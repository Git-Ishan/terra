variable "name" {
  type = string
  description = "Name of the security group"
}
variable "description" { 
  type = string
  description = "Description of the security group"
}
variable "vpc_id" {
  type = string
  description = "VPC ID where the security group will be created"
}
variable "ingress_port" {
  type = number
  description = "Port for ingress rules"
  default = 80
}
variable "tags" {
  type = map(string)
}
