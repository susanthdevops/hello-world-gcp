# Primary Function (us-central1)
resource "google_cloudfunctions_function" "primary" {
  name        = "hello-primary"
  description = "Primary Hello World function"
  runtime     = "nodejs20"
  region      = var.primary_region
  
  available_memory_mb = var.function_memory
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_archive.name
  trigger_http          = true
  entry_point           = "helloHttp"
  
  service_account_email = google_service_account.function_sa.email
  ingress_settings      = "ALLOW_INTERNAL_AND_GCLB"
}

# Secondary Function (us-west1)
resource "google_cloudfunctions_function" "secondary" {
  name        = "hello-secondary"
  description = "Secondary Hello World function"
  runtime     = "nodejs20"
  region      = var.secondary_region
  
  available_memory_mb = var.function_memory
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_archive.name
  trigger_http          = true
  entry_point           = "helloHttp"
  
  service_account_email = google_service_account.function_sa.email
  ingress_settings      = "ALLOW_INTERNAL_AND_GCLB"
}

# Common Storage Bucket
resource "google_storage_bucket" "function_bucket" {
  name     = "hello-function-bucket-${random_id.bucket_suffix.hex}"
  location = "US"
}

resource "google_storage_bucket_object" "function_archive" {
  name   = "function.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_archive.output_path
}

data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = "${path.module}/function"
  output_path = "${path.module}/function.zip"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}