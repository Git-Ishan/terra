variable "db_subnets" {
  type        = list(string)
}

variable "db_sg" {
  type        = string
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "db_name" {
  type        = string
  default     = "mydb"
}

variable "engine" {
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  default     = "11.22"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  type        = string
  default     = "postgres"
}

variable "db_pass" {
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  type        = string
  default     = "default.postgres11"
}

variable "storage_type" {
  type        = string
  default     = "gp2"
}
