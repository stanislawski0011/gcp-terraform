variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "machine_type" {
  description = "Machine type for compute instances"
  type        = string
  default     = "e2-medium"
}

variable "instance_count" {
  description = "Number of compute instances"
  type        = number
  default     = 2
}

variable "db_instance_name" {
  description = "Name of the database instance"
  type        = string
  default     = "webapp-db-dev"
}

variable "db_tier" {
  description = "Database instance tier"
  type        = string
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "webapp"
}

variable "db_user" {
  description = "Database user name"
  type        = string
  default     = "webapp"
}

variable "db_password" {
  description = "Database user password"
  type        = string
  sensitive   = true
}

variable "storage_bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "service_account_email" {
  description = "Email of the service account that will write to the bucket"
  type        = string
}

variable "terraform_state_bucket" {
  description = "The name of the GCS bucket for Terraform state"
  type        = string
  default     = "terraform-state-dev-0"
}