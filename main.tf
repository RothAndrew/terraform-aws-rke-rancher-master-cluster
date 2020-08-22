provider "aws" {
  region = var.region
}

provider "rke" {
  debug = true
}

locals {
  //  Most of these should eventually get moved to variables, but they are staying hard coded for now for simplicity.
  ssh_user           = "ubuntu"
  node_group_1_count = 1
  node_group_2_count = 1
  node_group_3_count = 1
  node_group_1_ami   = "ami-05801d0a3c8e4c443" // Ubuntu Bionic 18.04
  node_group_2_ami   = "ami-05801d0a3c8e4c443" // Ubuntu Bionic 18.04
  node_group_3_ami   = "ami-05801d0a3c8e4c443" // Ubuntu Bionic 18.04
}

module "label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.17.0"
  namespace          = var.namespace
  stage              = var.stage
  name               = var.name
  additional_tag_map = var.additional_tag_map
}
