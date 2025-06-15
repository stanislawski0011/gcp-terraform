provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "apis" {
  source = "../../modules/apis"

  project_id = var.project_id
}

module "networking" {
  source = "../../modules/networking"

  project_id          = var.project_id
  region             = var.region
  environment        = var.environment
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  depends_on         = [module.apis]
}

module "compute" {
  source = "../../modules/compute"

  project_id     = var.project_id
  region         = var.region
  environment    = var.environment
  machine_type   = var.machine_type
  instance_count = var.instance_count
  subnet_id      = module.networking.public_subnet_id
}

module "database" {
  source = "../../modules/database"

  project_id       = var.project_id
  environment      = var.environment
  region           = var.region
  db_instance_name = var.db_instance_name
  db_name          = var.db_name
  db_user          = var.db_user
  db_password      = var.db_password
  db_tier          = var.db_tier
  vpc_network_id   = module.networking.vpc_id

  depends_on = [module.networking]
}

module "storage" {
  source = "../../modules/storage"

  project_id            = var.project_id
  region                = var.region
  environment           = var.environment
  bucket_name           = var.storage_bucket_name
  service_account_email = var.service_account_email
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"

  project_id        = var.project_id
  environment       = var.environment
  instance_group_id = module.compute.instance_group_id
}