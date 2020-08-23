output "ssh_public_key" {
  description = "Cluster nodes' public SSH key"
  value       = tls_private_key.ssh.public_key_openssh
}

output "ssh_private_key" {
  description = "Cluster nodes' private SSH key"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "cluster_kubeconfig" {
  description = "KUBECONFIG yaml file contents to connect to the cluster. DO NOT USE unless you have no other options. All connections to the cluster should go through Rancher."
  value       = rke_cluster.default.kube_config_yaml
  sensitive   = true
}
