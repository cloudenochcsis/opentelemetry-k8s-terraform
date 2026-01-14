# DigitalOcean Kubernetes (DOKS) Terraform Configuration

This Terraform configuration provisions a managed Kubernetes cluster on DigitalOcean using official modules:
- `terraform-do-modules/vpc/digitalocean` - VPC network creation
- `terraform-do-modules/kubernetes/digitalocean` - Kubernetes cluster provisioning

## Features

- Dedicated VPC for network isolation
- Managed Kubernetes cluster with configurable version
- High Availability control plane option
- Auto-scaling node pools
- Automatic patch upgrades during maintenance windows
- Multiple node pools support
- Container registry integration
- Automatic kubeconfig generation

## Prerequisites

1. **DigitalOcean Account**: Sign up at [digitalocean.com](https://www.digitalocean.com/)
2. **DigitalOcean API Token**: Create a personal access token from the [API settings](https://cloud.digitalocean.com/account/api/tokens)
3. **Terraform**: Install Terraform >= 0.13 from [terraform.io](https://www.terraform.io/downloads.html)
4. **doctl** (optional): DigitalOcean CLI for checking available options

## Quick Start

### 1. Clone or Navigate to This Directory

```bash
git clone git@github.com:cloudenochcsis/opentelemetry-k8s-terraform.git
cd opentelemetry-k8s-terraform
```

### 2. Set Your DigitalOcean Token

```bash
export DIGITALOCEAN_TOKEN="your_digitalocean_api_token_here"
```

Alternatively, you can create a `terraform.tfvars` file:

```hcl
# Not recommended - use environment variable instead
# do_token = "your_digitalocean_api_token"
```

### 3. Configure Variables

Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your desired configuration.

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Review the Plan

```bash
terraform plan
```

### 6. Apply the Configuration

```bash
terraform apply
```

### 7. Access Your Cluster

After successful deployment, configure kubectl:

```bash
export KUBECONFIG=./kubeconfig
kubectl get nodes
```

## Configuration Options

### Available Regions

- `nyc1`, `nyc3` - New York
- `sfo3` - San Francisco
- `ams3` - Amsterdam
- `sgp1` - Singapore
- `lon1` - London
- `fra1` - Frankfurt
- `tor1` - Toronto
- `blr1` - Bangalore

### Available Node Sizes

| Size | vCPUs | Memory | Price/month |
|------|-------|--------|-------------|
| `s-1vcpu-2gb` | 1 | 2 GB | ~$12 |
| `s-2vcpu-4gb` | 2 | 4 GB | ~$24 |
| `s-4vcpu-8gb` | 4 | 8 GB | ~$48 |
| `s-8vcpu-16gb` | 8 | 16 GB | ~$96 |

Check current sizes with: `doctl compute size list`

### Check Available Kubernetes Versions

```bash
doctl kubernetes options versions
```

## Example Configurations

### Development Cluster (Minimal)

```hcl
# VPC
vpc_name     = "dev-vpc"
vpc_ip_range = "10.20.0.0/16"

# Cluster
cluster_name     = "dev-cluster"
environment      = "dev"
region           = "nyc1"
enable_ha        = false
node_size        = "s-1vcpu-2gb"
node_count       = 2
enable_autoscale = false
```

### Production Cluster (HA)

```hcl
# VPC
vpc_name     = "prod-vpc"
vpc_ip_range = "10.10.0.0/16"

# Cluster
cluster_name     = "prod-cluster"
environment      = "production"
region           = "nyc1"
enable_ha        = true
auto_upgrade     = true
node_size        = "s-4vcpu-8gb"
node_count       = 3
enable_autoscale = true
min_nodes        = 3
max_nodes        = 10
```

## Outputs

After deployment, you'll have access to:

**VPC Outputs:**
- `vpc_id` - VPC unique identifier
- `vpc_urn` - VPC uniform resource name
- `vpc_ip_range` - VPC IP address range
- `vpc_created_at` - VPC creation timestamp

**Cluster Outputs:**
- `cluster_id` - Cluster unique identifier
- `cluster_endpoint` - API server URL
- `cluster_token` - Authentication token
- `cluster_ca_certificate` - CA certificate
- `kubeconfig_path` - Path to kubeconfig file

View outputs:

```bash
terraform output
terraform output cluster_id
```

## Managing Multiple Node Pools

Add additional node pools in `terraform.tfvars`:

```hcl
additional_node_pools = {
  "compute-intensive" = {
    size       = "c-4"
    node_count = 2
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 4
    tags       = ["compute"]
  },
  "memory-optimized" = {
    size       = "m-4vcpu-32gb"
    VPC**: Free (no additional charge)
- **Control Plane**: Free for HA, included in worker node costs
- **Worker Nodes**: Based on droplet size and count
- **Load Balancers**: ~$12/month per load balancer
- **Block Storage**: ~$0.10/GB/month

Estimate your costs at [DigitalOcean Pricing Calculator](https://www.digitalocean.com/pricing/calculator)

## Security Best Practices

1. **Never commit tokens**: Use environment variables for DIGITALOCEAN_TOKEN
2. **Enable HA**: For production workloads
3. **Dedicated VPC**: Cluster runs in isolated VPC (configured by default)
4. **Auto-upgrades**: Enable for security patches
5. **RBAC**: Configure role-based access control
6. **Network Policies**: Implement pod network policies
7. **Private IP ranges**: Use non-overlapping CIDR blocks for VPC
## Cost Estimation

- **Control Plane**: Free for HA, included in worker node costs
- **Worker Nodes**: Based on droplet size and count
- **Load Balancers**: ~$12/month per load balancer
- **Block Storage**: ~$0.10/GB/month

Estimate your costs at [DigitalOcean Pricing Calculator](https://www.digitalocean.com/pricing/calculator)

## Security Best Practices

1. **Never commit tokens**: Use environment variables
2. **Enable HA**: For production workloads
3. **Use VPC**: Isolate cluster networking
4. **Auto-upgrades**: Enable for security patches
5. **RBAC**: Configure role-based access control
6. **Network Policies**: Implement pod network policies

## Troubleshooting

### Cluster stuck in "provisioning" state

```bash
terraform refresh
terraform apply
```

### Cannot connect to cluster

```bash
export KUBECONFIG=./kubeconfig
kubectl cluster-info
```

### Check DigitalOcean API limits

```bash
doctl account ratelimit
```

## Resources

- [DigitalOcean Kubernetes Documentation](https://docs.digitalocean.com/products/kubernetes/)
- [Terraform Module Source](https://github.com/terraform-do-modules/terraform-digitalocean-kubernetes)
- [Terraform Registry](https://registry.terraform.io/modules/terraform-do-modules/kubernetes/digitalocean/latest)
- [DigitalOcean API Documentation](https://docs.digitalocean.com/reference/api/)

## License

This configuration is provided as-is for educational and production use.
