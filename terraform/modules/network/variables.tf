variable "region" {}

variable "availability_zones" {
  type    = list(string)
  default = ["a", "b"]
}
