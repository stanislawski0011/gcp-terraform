terraform {
  backend "gcs" {
    bucket = "terraform-state-dev-5-463013"
    prefix = "terraform.tfstate"
  }
}
