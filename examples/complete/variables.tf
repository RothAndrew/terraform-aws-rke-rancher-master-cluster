variable "region" {
  type = string
}
variable "namespace" {
  type = string
}
variable "stage" {
  type = string
}
variable "name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "kubernetes_version" {
  type = string
}
variable "node_volume_size" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}
