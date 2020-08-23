output "ssh_public_key" {
  value = module.rke_rancher_master_cluster.ssh_public_key
}

output "ssh_private_key" {
  value     = module.rke_rancher_master_cluster.ssh_private_key
  sensitive = true
}

output "cluster_kubeconfig" {
  value     = module.rke_rancher_master_cluster.cluster_kubeconfig
  sensitive = true
}
