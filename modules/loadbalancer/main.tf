resource "google_compute_global_address" "default" {
  name    = "${var.environment}-global-ip"
  project = var.project_id
}

resource "google_compute_health_check" "http_health_check" {
  name               = "${var.environment}-http-health-check"
  check_interval_sec = 30  # Increased to reduce costs
  timeout_sec        = 5
  project            = var.project_id

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "web_backend" {
  name                  = "${var.environment}-web-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  project               = var.project_id

  backend {
    group = var.instance_group_id
  }

  health_checks = [google_compute_health_check.http_health_check.id]
}

resource "google_compute_url_map" "web_url_map" {
  name            = "${var.environment}-web-url-map"
  default_service = google_compute_backend_service.web_backend.id
  project         = var.project_id
}

resource "google_compute_target_http_proxy" "web_http_proxy" {
  name    = "${var.environment}-web-http-proxy"
  url_map = google_compute_url_map.web_url_map.id
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
  name       = "${var.environment}-web-forwarding-rule"
  target     = google_compute_target_http_proxy.web_http_proxy.id
  port_range = "80"
  project    = var.project_id
  ip_address = google_compute_global_address.default.address
}