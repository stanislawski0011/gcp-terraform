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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}