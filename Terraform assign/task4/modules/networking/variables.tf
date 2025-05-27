variable "vpc_id" {
  type        = string
}

variable "public_subnets" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}

variable "db_subnets" {
  type        = list(string)
}

variable "az_count" {
  type        = number
}

variable "tags" {
  type        = map(string)
  default     = {}
}
