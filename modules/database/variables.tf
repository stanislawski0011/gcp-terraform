variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  type        = string
}

variable "db_instance_name" {
  description = "The name of the database instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_user" {
  description = "The database user"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

variable "db_tier" {
  description = "The database instance tier"
  type        = string
}

variable "vpc_network_id" {
  description = "The VPC network ID"
  type        = string
}

variable "service_networking_connection" {
  description = "The service networking connection resource"
  type        = any
}