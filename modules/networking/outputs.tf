output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = google_compute_subnetwork.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = google_compute_subnetwork.private.id
}

output "nat_ip" {
  description = "The IP address of the NAT gateway"
  value       = google_compute_router_nat.nat.nat_ips
}

output "service_networking_connection" {
  value = google_service_networking_connection.private_services.id
}