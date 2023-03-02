output "instances_id" {
  value = aws_instance.public.*.id
}