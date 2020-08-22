variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev'"
}

variable "name" {
  type        = string
  description = "Solution name"
}

variable "region" {
  type        = string
  description = "AWS region to deploy to"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the cluster nodes"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy to"
}

variable "node_group_1_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 1 to"
}

variable "node_group_2_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 2 to"
}

variable "node_group_3_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 3 to"
}

variable "additional_tag_map" {
  type        = map(string)
  description = "Map of additional tags to apply to every taggable resource. If you don't want any use an empty map - '{}'"
}

variable "node_volume_size" {
  type        = string
  description = "Volume size of worker node disk in GB"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version to use. Must be supported by the version of the RKE provider you are using. See https://github.com/rancher/terraform-provider-rke/releases"
}
