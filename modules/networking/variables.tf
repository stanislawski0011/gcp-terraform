variable "project_id" {
  description = "The ID of the project where the VPC will be created"
  type        = string
}

variable "region" {
  description = "The region where the VPC will be created"
  type        = string
}

variable "environment" {
  description = "The environment (dev/prod)"
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