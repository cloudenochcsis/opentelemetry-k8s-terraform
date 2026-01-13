variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "doks-cluster"
}

variable "environment" {
  description = "Environment (e.g., prod, dev, staging)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "DigitalOcean region for the cluster"
  type        = string
  default     = "nyc1"
  # Available regions: nyc1, nyc3, ams3, sfo3, sgp1, lon1, fra1, tor1, blr1, etc.
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.31.1-do.5"
  # Check available versions: doctl kubernetes options versions
}

variable "enable_ha" {
  description = "Enable high availability control plane"
  type        = bool
  default     = true
}

variable "auto_upgrade" {
  description = "Enable automatic patch upgrades during maintenance window"
  type        = bool
  default     = false
}

variable "surge_upgrade" {
  description = "Enable surge upgrade for faster upgrades"
  type        = bool
  default     = false
}

variable "maintenance_day" {
  description = "Day of the week for maintenance window (e.g., monday, tuesday, any)"
  type        = string
  default     = "any"
}

variable "maintenance_start_time" {
  description = "Start time for maintenance window (HH:MM format)"
  type        = string
  default     = "5:00"
}

variable "node_size" {
  description = "Size of the worker nodes (e.g., s-2vcpu-4gb, s-4vcpu-8gb)"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "enable_autoscale" {
  description = "Enable node pool autoscaling"
  type        = bool
  default     = true
}

variable "min_nodes" {
  description = "Minimum number of nodes when autoscaling is enabled"
  type        = number
  default     = 2
}

variable "max_nodes" {
  description = "Maximum number of nodes when autoscaling is enabled"
  type        = number
  default     = 5
}

variable "additional_node_pools" {
  description = "Additional node pools for the cluster"
  type        = map(any)
  default     = {}
  # Example:
  # {
  #   "compute-pool" = {
  #     size       = "s-4vcpu-8gb"
  #     node_count = 2
  #     auto_scale = true
  #     min_nodes  = 1
  #     max_nodes  = 4
  #     tags       = ["compute", "workload"]
  #   }
  # }
}

# VPC Configuration
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "doks-vpc"
}

variable "vpc_description" {
  description = "Description of the VPC"
  type        = string
  default     = "VPC for DigitalOcean Kubernetes cluster"
}

variable "vpc_ip_range" {
  description = "The range of IP addresses for the VPC in CIDR notation (must be /16 to /24)"
  type        = string
  default     = "10.10.0.0/16"
  # Common private IP ranges:
  # 10.0.0.0/16 to 10.255.0.0/16
  # 172.16.0.0/16 to 172.31.0.0/16
  # 192.168.0.0/16
}

variable "enable_registry" {
  description = "Enable DigitalOcean container registry integration"
  type        = bool
  default     = false
}

variable "kubeconfig_path" {
  description = "Path to save the kubeconfig file"
  type        = string
  default     = "./kubeconfig"
}

variable "tags" {
  description = "List of tags to apply to the cluster"
  type        = list(string)
  default     = ["terraform-managed", "doks"]
}

variable "label_order" {
  description = "Label order for resource naming"
  type        = list(any)
  default     = ["name", "environment"]
}
