variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "machine_type" {
  description = "Machine type for compute instances"
  type        = string
}

variable "instance_count" {
  description = "Number of compute instances"
  type        = number
}

variable "subnet_id" {
  description = "The ID of the subnet to deploy instances"
  type        = string
}