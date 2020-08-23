# terraform-aws-rke-rancher-master-cluster

Terraform module that creates an RKE cluster with Rancher running on it, meant to serve as nothing but a highly-available Rancher "master" cluster.

**NOTE:** This module is very new and is in a high state of flux. Until informed otherwise, do not expect to be able to upgrade from one version of the module to another as the changes being made will likely cause Terraform to want to destroy the existing EC2 instances and create new ones, which would wipe out your Rancher master cluster. Hopefully it goes without saying that this module should not be used in production until it has a good upgrade path.

## Introduction

### Purpose

The purpose of this module is to give an easy way to stand up a production-ready Rancher "master" cluster. It is intended to be a "turn-key" module, so it includes (almost) everything needed to have Rancher up and running, including the Kubernetes cluster, load balancer, Route53 DNS entry, and the Rancher deployment itself.

When presented with the option between something more elegant, or something more simple, the more simple route will always be taken. This module is meant to be easy to understand and maintain. Conditional logic that turns things on and off will be kept to a minimum.

### What it provisions

- 3 "node groups" of EC2 instances - gives you the ability to upgrade the AMI of one node group at a time to keep the cluster running. Currently does not use AutoScalingGroup due to limitations with how RKE works. Assuming it is possible, an enhancement to this module to use ASG would be welcomed if it doesn't add a lot of complexity.
  - Currently it creates Ubuntu nodes with Docker installed since that was what others that came before this had done. In a later release CentOS will be used with optional use of Red Hat Enterprise Linux instead.
  - All nodes are labeled as `["controlplane", "etcd", "worker"]` - Remember this cluster should be used as the Rancher master and nothing else
- A Classic Load Balancer with listeners on port 80 and port 443 that points to ports 80 and 443 of the cluster nodes
- 2 Security Groups
  - The `nodes` security group is used by the EC2 instances and allows:
    - Any traffic inside its own security group
    - SSH traffic from anywhere
    - K8s API traffic from anywhere
    - Traffic on ports 80 and 443 from the `elb` security group
  - The `elb` security group is used by the load balancer and allows:
    - Traffic on ports 80 and 443 from anywhere
- An AWS Key Pair with a new TLS private key - Support for using an existing key pair may be added in the future if desired.
- A Kubernetes cluster using RKE
- A Route53 record that configures a dnsName to point at the ELB - Support for optionally disabling this resource may be added in the future if desired.
- Rancher Server and associated dependencies via Helm deployments

### Limitations

- At the moment, this module cannot be deployed to private subnets. If this is something a lot of people want, an enhancement may be made to use a bastion host, but doing so will add a lot of complexity which goes against the desire to keep this module as simple and maintainable as possible.

## Usage

### Prerequisites

- Terraform v0.13+ - Uses the new way to pull down 3rd party providers
- \*nix operating system - The decision has been made to not support Windows. If you want to use this module on Windows, you should use it inside a docker container.

### Instructions

See [examples/complete](examples/complete) for an example of how to use this module. This module does not require anything special, just use the standard `terraform apply`/`terraform destroy`.

## Developer Guide

Contributors to this module should make themselves familiar with this section.

### Prerequisites

- Terraform v0.13+
- [pre-commit](https://pre-commit.com/)
- Pre-commit hook dependencies
  - nodejs (for the prettier hook)
  - [tflint](https://github.com/terraform-linters/tflint)
  - [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- Run `pre-commit install` in root dir of repo (installs the pre-commit hooks so they run automatically when you try to do a git commit)

### Versioning

This module will use SemVer, and will stay on v0.X for the forseeable future

### TO-DO

[X] test

<!-- prettier-ignore-start -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0, < 0.14.0 |
| aws | >= 2.0.0, < 3.0.0 |
| random | >= 2.0.0, < 3.0.0 |
| rke | >= 1.0.0, < 2.0.0 |
| template | >= 2.0.0, < 3.0.0 |
| tls | >= 2.0.0, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.0.0, < 3.0.0 |
| random | >= 2.0.0, < 3.0.0 |
| rke | >= 1.0.0, < 2.0.0 |
| template | >= 2.0.0, < 3.0.0 |
| tls | >= 2.0.0, < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Map of additional tags to apply to every taggable resource. If you don't want any use an empty map - '{}' | `map(string)` | n/a | yes |
| instance\_type | Instance type to use for the cluster nodes | `string` | n/a | yes |
| kubernetes\_version | Kubernetes version to use. Must be supported by the version of the RKE provider you are using. See https://github.com/rancher/terraform-provider-rke/releases | `string` | n/a | yes |
| name | Solution name | `string` | n/a | yes |
| namespace | Namespace, which could be your organization name or abbreviation | `string` | n/a | yes |
| node\_group\_1\_subnet\_id | Subnet to deploy node group 1 to | `string` | n/a | yes |
| node\_group\_2\_subnet\_id | Subnet to deploy node group 2 to | `string` | n/a | yes |
| node\_group\_3\_subnet\_id | Subnet to deploy node group 3 to | `string` | n/a | yes |
| node\_volume\_size | Volume size of worker node disk in GB | `string` | n/a | yes |
| region | AWS region to deploy to | `string` | n/a | yes |
| stage | Stage, e.g. 'prod', 'staging', 'dev' | `string` | n/a | yes |
| vpc\_id | ID of the VPC to deploy to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_kubeconfig | [SENSITIVE] KUBECONFIG yaml file contents to connect to the cluster. DO NOT USE unless you have no other options. Users should use the KUBECONFIG that Rancher provides to them rather than this. |
| ssh\_private\_key | [SENSITIVE] Cluster nodes' private SSH key |
| ssh\_public\_key | Cluster nodes' public SSH key |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- prettier-ignore-end -->
