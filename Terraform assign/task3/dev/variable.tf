variable "ami_id" {
 type = string 
}

variable "common_tags" {
  type = map(string)
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "instance_type" {
  type = string
  # default = "t2.micro"
}

variable "availability_zone" {
  type = string
  default = ""
}
variable "cidr_block" {
  type = string
}