output "instance_group_id" {
  description = "The ID of the instance group"
  value       = google_compute_instance_group_manager.web_group.instance_group
}

output "instance_group_name" {
  description = "The name of the instance group"
  value       = google_compute_instance_group_manager.web_group.name
}

output "health_check_id" {
  description = "The ID of the health check"
  value       = google_compute_health_check.web_health_check.id
}

output "autoscaler_id" {
  description = "The ID of the autoscaler"
  value       = google_compute_autoscaler.web_autoscaler.id
}