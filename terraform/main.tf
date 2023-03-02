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

module "rds" {
  source             = "./modules/rds"
  private_subnets_id = module.network.private_subnets_id
  rds_sg_id          = module.network.rds_sg
  rds_name           = var.rds_name
  rds_username       = var.rds_username
  rds_password       = var.rds_password
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  vpc_id            = module.network.vpc_id
  security_group_id = module.network.default_sg
  subnets           = module.network.public_subnets_id
  instances_id      = module.ec2.instances_id
}

# Export Terraform variable values to an Ansible var_file
resource "local_file" "tf_ansible_vars_file" {
  content  = <<-DOC
    # Ansible vars_file containing variable values from Terraform.
    # Generated by Terraform mgmt configuration.

    db_host: ${module.rds.rds_host}
    db_user: ${var.rds_username}
    db_password: ${var.rds_password}
    db_name: ${module.rds.rds_db_name}
    DOC
  filename = "../ansible/install_app/defaults/rds.yml"
}
