variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
  default = ""
}
variable "tags" {
  type = map(string)
}