output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = google_compute_global_forwarding_rule.web_forwarding_rule.ip_address
}

output "load_balancer_name" {
  description = "The name of the load balancer"
  value       = google_compute_global_forwarding_rule.web_forwarding_rule.name
}

output "backend_service_id" {
  description = "The ID of the backend service"
  value       = google_compute_backend_service.web_backend.id
}

output "url_map_id" {
  description = "The ID of the URL map"
  value       = google_compute_url_map.web_url_map.id
}