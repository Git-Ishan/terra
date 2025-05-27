variable "vpc_cidr" {
  type        = string
}

variable "az_count" {
  type        = number
}

variable "availability_zones" {
  type        = list(string)
}

variable "tags" {
  type        = map(string)
  default     = {}
}
