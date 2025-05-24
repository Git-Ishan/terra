variable "subnet_id" {
  type = string
  description = "Subnet ID for the NAT Gateway"
}
variable "tags" {
  type = map(string)
}
variable allocation_id {
  type = string
  description = "EIP allocation ID for the NAT Gateway"
}