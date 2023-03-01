provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "ec2" {
  source            = "./modules/ec2"
  ssh_pub_key_path  = var.ssh_pub_key_path
  public_subnets_id = module.network.public_subnets_id
  security_group    = module.network.default_sg
}
