output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_id" {
  value = aws_subnet.public.*.id
}

output "default_sg" {
  value = aws_security_group.default.id
}