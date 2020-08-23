region             = "us-east-1"
namespace          = "example"
stage              = "test"
name               = "rke-rancher-master-cluster"
instance_type      = "t3a.medium"
kubernetes_version = "v1.18.3-rancher2-2"
node_volume_size   = "50"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
