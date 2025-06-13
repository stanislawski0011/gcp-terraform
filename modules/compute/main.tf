resource "google_compute_instance_template" "web_template" {
  name_prefix  = "${var.environment}-web-template-"
  machine_type = var.machine_type
  project      = var.project_id

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
    disk_size_gb = 10  # Free tier limit
  }

  network_interface {
    subnetwork = var.subnet_id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    startup-script = <<-SCRIPT
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      systemctl start nginx
      systemctl enable nginx
    SCRIPT
  }

  tags = ["http-server", "https-server"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "web_group" {
  name               = "${var.environment}-web-group"
  base_instance_name = "${var.environment}-web"
  zone               = "${var.region}-a"
  project            = var.project_id

  version {
    instance_template = google_compute_instance_template.web_template.id
  }

  target_size = var.instance_count

  named_port {
    name = "http"
    port = 80
  }

  named_port {
    name = "https"
    port = 443
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.web_health_check.id
    initial_delay_sec = 300
  }
}

resource "google_compute_health_check" "web_health_check" {
  name               = "${var.environment}-web-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  project            = var.project_id

  http_health_check {
    port = 80
  }
}

resource "google_compute_autoscaler" "web_autoscaler" {
  name    = "${var.environment}-web-autoscaler"
  zone    = "${var.region}-a"
  project = var.project_id
  target  = google_compute_instance_group_manager.web_group.id

  autoscaling_policy {
    max_replicas    = 2  # Maximum 2 instances (free tier limit)
    min_replicas    = 1  # Minimum 1 instance
    cooldown_period = 60

    cpu_utilization {
      target = 0.75
    }
  }
}