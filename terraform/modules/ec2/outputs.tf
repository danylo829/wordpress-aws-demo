output "instances_id" {
  value = aws_instance.public.*.id
}

output "instances_public_ip" {
  value = aws_instance.public.*.public_ip
}