resource "aws_key_pair" "dev_key" {
  key_name   = "dev"
  public_key = file(var.ssh_pub_key_path)
}

# Launch an EC2 instance in the public subnet
resource "aws_instance" "public" {
  count                       = length(var.public_subnets_id)
  ami                         = "ami-09e1162c87f73958b"
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnets_id[count.index]
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = true

  tags = {
    Name = "public-ec2-instance-${count.index}"
  }

  key_name = aws_key_pair.dev_key.key_name
}
