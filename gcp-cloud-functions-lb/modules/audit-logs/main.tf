resource "google_storage_bucket" "audit_logs_bucket" {
  name     = var.bucket_name
  location = var.location
  force_destroy = true
}

resource "google_logging_project_sink" "audit_logs_sink" {
  name        = var.sink_name
  destination = "storage.googleapis.com/${google_storage_bucket.audit_logs_bucket.name}"
  filter      = var.filter
}

resource "google_storage_bucket_iam_member" "sink_writer" {
  bucket = google_storage_bucket.audit_logs_bucket.name
  role   = "roles/storage.objectCreator"
  member = google_logging_project_sink.audit_logs_sink.writer_identity
}

resource "google_logging_project_exclusion" "exclude_data_access_logs" {
  name        = var.exclusion_name
  description = var.exclusion_description
  filter      = var.exclusion_filter
}