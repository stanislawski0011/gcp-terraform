variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "instance_group_id" {
  description = "The ID of the instance group"
  type        = string
}