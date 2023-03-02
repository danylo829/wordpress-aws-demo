output "rds_host" {
  value = aws_db_instance.rds.endpoint
}

output "rds_db_name" {
  value = aws_db_instance.rds.db_name
}