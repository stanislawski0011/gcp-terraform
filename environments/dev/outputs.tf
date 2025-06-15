output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = module.loadbalancer.load_balancer_ip
}

output "database_connection_name" {
  description = "The connection name of the database instance"
  value       = module.database.instance_connection_name
}

output "storage_bucket_url" {
  description = "The URL of the GCS bucket"
  value       = module.storage.bucket_url
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

output "instance_group_id" {
  description = "The ID of the instance group"
  value       = module.compute.instance_group_id
}