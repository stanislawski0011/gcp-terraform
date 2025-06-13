output "ip_address" {
  description = "The IP address of the load balancer"
  value       = google_compute_global_address.default.address
}

output "backend_service_id" {
  description = "The ID of the backend service"
  value       = google_compute_backend_service.web_backend.id
}

output "url_map_id" {
  description = "The ID of the URL map"
  value       = google_compute_url_map.web_url_map.id
}

output "ssl_certificate_id" {
  description = "The ID of the SSL certificate"
  value       = google_compute_managed_ssl_certificate.web_cert.id
}