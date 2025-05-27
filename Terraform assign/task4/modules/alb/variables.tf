variable "vpc_id" {
  type        = string
}

variable "public_subnets" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}

variable "web_sg" {
  type        = string
}

variable "app_sg" {
  type        = string
}

variable "web_target_arn" {
  type        = string
}

variable "app_target_arn" {
  type        = string
}

variable "app_port" {
  type        = number
  default     = 8080
}

variable "enable_https" {
  type        = bool
  default     = false
}

variable "certificate_arn" {
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
}
