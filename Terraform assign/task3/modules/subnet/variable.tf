variable "vpc_id" {
  type = string
  description = "VPC ID"
}
variable "cidr_block" {
  type = string
  description = "CIDR block for the subnet"
}
variable "availability_zone" {
  type = string
  description = "Availability Zone for the subnet"
}
variable "public" {
  type    = bool
  default = false
}
variable "tags" {
  type = map(string)
}