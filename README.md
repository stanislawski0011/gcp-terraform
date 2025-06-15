# GCP Web Application Infrastructure

This repository contains Terraform code to provision a scalable and highly available web application infrastructure on Google Cloud Platform (GCP).

## Infrastructure Components

- **Web Server**: Nginx running on Google Compute Engine instances in an instance group
- **Database**: Cloud SQL PostgreSQL instance
- **Storage**: Google Cloud Storage bucket for static assets
- **Load Balancer**: Global HTTP(S) load balancer for high availability
- **VPC Network**: Custom VPC with public and private subnets
- **Security**: Firewall rules, IAM policies, and SSL certificates

## Project Structure

```
.
├── environments/
│   ├── dev/
│   └── prod/
├── modules/
│   ├── compute/
│   ├── database/
│   ├── storage/
│   ├── networking/
│   └── loadbalancer/
├── scripts/
│   └── init-backend.sh
├── variables.tf
├── outputs.tf
├── main.tf
├── versions.tf
└── .terraform-version
```

## Prerequisites

- Google Cloud Platform account
- Google Cloud SDK installed
- tfenv for Terraform version management
- gcloud CLI configured with appropriate credentials

## Setup Instructions

1. Install tfenv (if not already installed):
   ```bash
   # macOS
   brew install tfenv

   # Linux
   git clone https://github.com/tfutils/tfenv.git ~/.tfenv
   echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
   ```

2. Install the required Terraform version:
   ```bash
   tfenv install
   ```

3. Configure your GCP credentials and project:
   ```bash
   # Login to GCP first
   gcloud auth application-default login

   # List available projects
   gcloud projects list

   # Set your project
   gcloud config set project <your-project-id>

   # Verify the project is set
   gcloud config get-value project
   ```

4. Initialize the Terraform state backend:
   ```bash
   ./scripts/init-backend.sh <your-project-id>
   ```

5. Initialize Terraform:
   ```bash
   cd environments/dev && terraform init
   ```

6. Create a `terraform.tfvars` file with your configuration:
   ```hcl
   project_id     = "your-project-id"
   region         = "us-central1"
   environment    = "dev"
   ```

7. Plan the infrastructure:
   ```bash
   terraform plan
   ```

8. Apply the configuration:
   ```bash
   terraform apply
   ```

## State Management

The Terraform state is stored in a Google Cloud Storage bucket with the following features:
- Versioning enabled for state history
- Uniform bucket-level access for security
- State file path: `gs://terraform-state-<project-id>/dev/terraform.tfstate`


## Maintenance

- Regular backups are configured for the database
- Monitoring and logging are set up using Cloud Monitoring
- Auto-scaling is configured based on CPU and memory usage

## Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

## License

MIT