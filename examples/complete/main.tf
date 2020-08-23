provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "1.0.1"
      debug   = true
    }
  }
}

module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.16.1"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  cidr_block = "172.16.0.0/16"
}

module "subnets" {
  source               = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.27.0"
  availability_zones   = var.availability_zones
  namespace            = var.namespace
  stage                = var.stage
  name                 = var.name
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false
}

module "rke_rancher_master_cluster" {
  source                 = "../.."
  additional_tag_map     = {}
  instance_type          = var.instance_type
  kubernetes_version     = var.kubernetes_version
  name                   = var.name
  namespace              = var.namespace
  node_group_1_subnet_id = module.subnets.public_subnet_ids[0]
  node_group_2_subnet_id = module.subnets.public_subnet_ids[1]
  node_group_3_subnet_id = module.subnets.public_subnet_ids[2]
  node_volume_size       = var.node_volume_size
  region                 = var.region
  stage                  = var.stage
  vpc_id                 = module.vpc.vpc_id
}
