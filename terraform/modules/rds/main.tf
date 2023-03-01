# Custom subnet group
resource "aws_db_subnet_group" "default" {
  name       = "subnet-group"
  subnet_ids = var.private_subnets_id
}

# RDS instance
resource "aws_db_instance" "rds" {
  identifier             = "rds"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  name                   = var.rds_name
  username               = var.rds_username
  password               = var.rds_name
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.rds_sg_id]
}
