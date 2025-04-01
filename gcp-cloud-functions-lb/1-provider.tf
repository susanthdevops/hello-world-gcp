# Terraform Settings Block
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 6.25.0"
    }
  }
  
  /*# Remote Backend
  backend "gcs" {
    bucket = "msh_demo_bucket"
    prefix = "terraform/state"
  }
  */
}

provider "google" {
  project = var.project_id
  region  = var.primary_region
}
