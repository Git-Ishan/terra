variable "vpc_id" {
  type        = string
}

variable "web_subnets" {
  type        = list(string)
}

variable "app_subnets" {
  type        = list(string)
}

variable "web_sg" {
  type        = string
}

variable "app_sg" {
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "user_data" {
  type        = string
  default     = ""
}

variable "app_port" {
  type        = number
  default     = 8080
}

variable "tags" {
  type        = map(string)
  default     = {}
}
