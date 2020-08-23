# terraform-aws-rke-rancher-master-cluster

Terraform module that creates an RKE cluster, meant to serve as nothing but a highly-available Rancher "master" cluster

## Purpose

The purpose of this module is to give an easy way to stand up a production-ready Rancher "master" cluster. It is intended to be a "turn-key" module, so it includes (almost) everything needed to have Rancher up and running, including the Kubernetes cluster, load balancer, Route53 DNS entry, and the Rancher deployment itself.

When presented with the option between something more elegant, or something more simple, the more simple route will always be taken. This module is meant to be easy to understand and maintain. Conditional logic that turns things on and off will be kept to a minimum.

## Usage

### Prerequisites

## Developer Guide

Contributors to this module should make themselves familiar with this section.

### Versioning

This module will use SemVer, and will stay on v0.X for the forseeable future

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
