output "bucket_name" {
  value       = aws_s3_bucket.state_bucket.bucket
  description = "The name of state bucket (used in backend.conf)"
}

output "bucket_region" {
  value       = aws_s3_bucket.state_bucket.region
  description = "The region of state bucket (used in backend.conf)"
}
