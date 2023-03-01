variable "region" {
  description = "Region where to deploy project"
  type        = string
}

variable "ssh_pub_key_path" {
  type = string
  description = "Path for public ssh key"
}
