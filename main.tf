terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.28.1"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Create VPC for the Kubernetes cluster
module "vpc" {
  source  = "terraform-do-modules/vpc/digitalocean"
  version = "1.0.0"

  # VPC Configuration
  name        = var.vpc_name
  environment = var.environment
  region      = var.region
  description = var.vpc_description
  ip_range    = var.vpc_ip_range

  # Labels
  label_order = var.label_order
  managedby   = "terraform"
}

module "kubernetes_cluster" {
  source  = "terraform-do-modules/kubernetes/digitalocean"
  version = "1.1.1"

  # Cluster Configuration
  name             = var.cluster_name
  environment      = var.environment
  region           = var.region
  cluster_version  = var.cluster_version
  
  # High Availability & Auto Upgrade
  ha           = var.enable_ha
  auto_upgrade = var.auto_upgrade
  surge_upgrade = var.surge_upgrade

  # Maintenance Window
  maintenance_policy = {
    day        = var.maintenance_day
    start_time = var.maintenance_start_time
  }

  # Default/Critical Node Pool
  critical_node_pool = {
    critical = {
      name       = "critical-pool"
      size       = var.node_size
      node_count = var.node_count
      auto_scale = var.enable_autoscale
      min_nodes  = var.min_nodes
      max_nodes  = var.max_nodes
      tags       = concat(var.tags, ["critical"])
    }
  }

  # Additional Node Pools (optional)
  app_node_pools = var.additional_node_pools

  # VPC Configuration - Use the created VPC
  vpc_uuid = module.vpc.id

  # Container Registry Integration
  registry_integration = var.enable_registry

  # Kubeconfig
  kubeconfig_path = var.kubeconfig_path

  # Tags
  tags = var.tags

  # Labels
  label_order = var.label_order
  managedby   = "terraform"
}
