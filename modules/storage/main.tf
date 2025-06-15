resource "google_storage_bucket" "web_storage" {
  name          = var.bucket_name
  location      = var.region
  project       = var.project_id
  force_destroy = var.environment != "prod"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = false # Disabled to save costs
  }

  lifecycle_rule {
    condition {
      age = 1 # Delete objects after 1 day to save costs
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket_iam_member" "service_account_access" {
  bucket = google_storage_bucket.web_storage.name
  role   = "roles/storage.objectViewer"
  member = "user:${var.service_account_email}"
}