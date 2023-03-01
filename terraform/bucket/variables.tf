variable "region" {
  description = "Region where to deploy bucket"
  type        = string
  default     = "eu-north-1"
}
variable "bucket_name" {
  description = "The name of state storage bucket"
  type        = string
  default     = "wordpress-demo-terraform-state"
}
