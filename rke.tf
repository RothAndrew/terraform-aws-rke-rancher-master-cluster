resource "rke_cluster" "default" {
  dynamic nodes {
    for_each = aws_instance.node_group_1
    content {
      address          = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      user             = local.ssh_user
      role             = ["controlplane", "etcd", "worker"]
      ssh_key          = tls_private_key.ssh.private_key_pem
    }
  }

  dynamic nodes {
    for_each = aws_instance.node_group_2
    content {
      address          = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      user             = local.ssh_user
      role             = ["controlplane", "etcd", "worker"]
      ssh_key          = tls_private_key.ssh.private_key_pem
    }
  }

  dynamic nodes {
    for_each = aws_instance.node_group_3
    content {
      address          = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      user             = local.ssh_user
      role             = ["controlplane", "etcd", "worker"]
      ssh_key          = tls_private_key.ssh.private_key_pem
    }
  }

  cluster_name       = module.label.id
  kubernetes_version = var.kubernetes_version
}
