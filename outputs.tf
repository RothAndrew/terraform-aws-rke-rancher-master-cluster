output "ssh_public_key" {
  value = tls_private_key.ssh.public_key_openssh
}

output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}

output "cluster_kubeconfig" {
  value     = rke_cluster.default.kube_config_yaml
  sensitive = true
}
