terraform {
  backend "gcs" {
    bucket = "terraform-state-dev-0-462813"
    prefix = "terraform.tfstate"
  }
}