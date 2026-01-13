# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.id
}

output "vpc_urn" {
  description = "The URN of the VPC"
  value       = module.vpc.urn
}

output "vpc_created_at" {
  description = "The date and time when the VPC was created"
  value       = module.vpc.created_at
}

output "vpc_ip_range" {
  description = "The IP range of the VPC"
  value       = var.vpc_ip_range
}

# Cluster Outputs
output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = module.kubernetes_cluster.id
}

output "cluster_urn" {
  description = "The URN of the Kubernetes cluster"
  value       = module.kubernetes_cluster.urn
}

output "cluster_endpoint" {
  description = "The base URL of the API server on the Kubernetes master node"
  value       = module.kubernetes_cluster.endpoint
  sensitive   = true
}

output "cluster_status" {
  description = "The current status of the cluster"
  value       = module.kubernetes_cluster.status
}

output "cluster_version" {
  description = "The Kubernetes version of the cluster"
  value       = var.cluster_version
}

output "cluster_subnet" {
  description = "The range of IP addresses in the overlay network of the Kubernetes cluster"
  value       = module.kubernetes_cluster.cluster_subnet
}

output "service_subnet" {
  description = "The range of assignable IP addresses for services running in the cluster"
  value       = module.kubernetes_cluster.service_subnet
}

output "ipv4_address" {
  description = "The public IPv4 address of the Kubernetes master node (not set for HA clusters)"
  value       = module.kubernetes_cluster.ipv4_address
}

output "cluster_token" {
  description = "The token used to authenticate with the cluster"
  value       = module.kubernetes_cluster.token
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The certificate authority used to verify the cluster's API server"
  value       = module.kubernetes_cluster.cluster_ca_certificate
  sensitive   = true
}

output "default_node_pool_id" {
  description = "The ID of the default node pool"
  value       = module.kubernetes_cluster.default_node_pool_id
}

output "created_at" {
  description = "The date and time when the Kubernetes cluster was created"
  value       = module.kubernetes_cluster.created_at
}

output "updated_at" {
  description = "The date and time when the Kubernetes cluster was last updated"
  value       = module.kubernetes_cluster.updated_at
}

output "kubeconfig_path" {
  description = "Path to the generated kubeconfig file"
  value       = var.kubeconfig_path
}
