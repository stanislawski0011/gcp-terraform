resource "google_storage_bucket" "web_storage" {
  name          = var.bucket_name
  location      = var.region
  project       = var.project_id
  force_destroy = var.environment != "prod"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_key.id
  }

  logging {
    log_bucket = google_storage_bucket.logs.id
  }

  retention_policy {
    is_locked        = var.environment == "prod"
    retention_period = 365 * 24 * 60 * 60 # 1 year in seconds
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket" "logs" {
  name          = "${var.bucket_name}-logs"
  location      = var.region
  project       = var.project_id
  force_destroy = var.environment != "prod"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_kms_key_ring" "bucket_keyring" {
  name     = "${var.bucket_name}-keyring"
  location = var.region
  project  = var.project_id
}

resource "google_kms_crypto_key" "bucket_key" {
  name     = "${var.bucket_name}-key"
  key_ring = google_kms_key_ring.bucket_keyring.id

  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }

  rotation_period = "7776000s" # 90 days

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_storage_bucket_iam_member" "service_account_access" {
  bucket = google_storage_bucket.web_storage.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account_email}"
}