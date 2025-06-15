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

variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "service_account_email" {
  description = "Email of the service account that will write to the bucket"
  type        = string
}