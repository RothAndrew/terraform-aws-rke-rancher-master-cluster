# terraform-aws-rke-rancher-master-cluster

Terraform module that creates an RKE cluster, meant to serve as nothing but a highly-available Rancher "master" cluster

## Purpose

The purpose of this module is to give an easy way to stand up a production-ready Rancher "master" cluster. It is intended to be a "turn-key" module, so it includes (almost) everything needed to have Rancher up and running, including the Kubernetes cluster, load balancer, Route53 DNS entry, and the Rancher deployment itself.

When presented with the option between something more elegant, or something more simple, the more simple route will always be taken. This module is meant to be easy to understand and maintain. Conditional logic that turns things on and off will be kept to a minimum.

In order to support GovCloud and DISA requirements, RKE is used rather than EKS

## Usage

### Prerequisites

#### Operating System

A \*nix operating system is required, since a `local_exec` runs some bash code

#### Terraform Version

Since it uses the new method of getting providers, this module requires Terraform 0.13+

## Developer Guide

Contributors to this module should make themselves familiar with this section.

### Versioning

This module will use SemVer, and will stay on v0.X for the forseeable future
