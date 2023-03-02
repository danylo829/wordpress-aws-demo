resource "aws_key_pair" "dev_key" {
  key_name   = "dev"
  public_key = file(var.ssh_pub_key_path)
}

data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 instance in the public subnet
resource "aws_instance" "public" {
  count                       = length(var.public_subnets_id)
  ami                         = data.aws_ami.ubuntu_2204.id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnets_id[count.index]
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = true

  tags = {
    Name = "app-instance-${count.index}"
  }

  key_name = aws_key_pair.dev_key.key_name
}
