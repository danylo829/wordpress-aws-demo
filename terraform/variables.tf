variable "region" {
  description = "Region where to deploy project"
  type        = string
}

variable "ssh_pub_key_path" {
  type = string
  description = "Path for public ssh key"
}

variable "rds_name" {
  type = string
  description = "The name of RDS"
}

variable "rds_username" {
  type = string
  description = "The name of RDS user"
}

variable "rds_password" {
  type = string
  description = "The password of RDS user"
}