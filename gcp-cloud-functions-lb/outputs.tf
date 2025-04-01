output "load_balancer_ip" {
  value       = google_compute_global_forwarding_rule.http.ip_address
  description = "Load Balancer public IP address"
}

output "primary_function_url" {
  value       = google_cloudfunctions_function.primary.https_trigger_url
  description = "Primary Cloud Function URL"
}

output "secondary_function_url" {
  value       = google_cloudfunctions_function.secondary.https_trigger_url
  description = "Secondary Cloud Function URL"
}

output "audit_logs_bucket" {
  value       = module.audit_logs.bucket_name
  description = "Audit logs storage bucket name"
}

output "load_balancer_details" {
  value = {
    ip       = google_compute_global_forwarding_rule.http.ip_address
    protocol = google_compute_target_http_proxy.default.name
    ports    = "80"
  }
  description = "Load Balancer network details"
}