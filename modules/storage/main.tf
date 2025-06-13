resource "google_storage_bucket" "web_storage" {
  name          = var.bucket_name
  location      = var.region
  project       = var.project_id
  force_destroy = true # Allow easy cleanup after interview

  uniform_bucket_level_access = true

  versioning {
    enabled = false # Disabled to save costs
  }

  lifecycle_rule {
    condition {
      age = 1 # Delete objects after 1 day
    }
    action {
      type = "Delete"
    }
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_member" "public_read" {
  bucket = google_storage_bucket.web_storage.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "service_account_write" {
  bucket = google_storage_bucket.web_storage.name
  role   = "roles/storage.objectViewer"
  member = "user:${var.service_account_email}"
}