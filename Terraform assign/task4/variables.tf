variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "network_cidr_block" {
  type    = string
  default = "172.31.0.0/16"
}

variable "zone_count" {
  type    = number
  default = 2
}

variable "zones_list" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "database_password" {
  type      = string
  sensitive = true
}

variable "ssh_key" {
  type = string
}

variable "vm_type" {
  type    = string
  default = "t3.micro"
}

variable "image_id" {
  type = string
}

variable "bootstrap_script" {
  type    = string
  default = ""
}
