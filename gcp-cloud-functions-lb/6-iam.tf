# Allow Cloud Function Service Account to invoke itself
resource "google_cloudfunctions_function_iam_binding" "invoker" {
  for_each = {
    primary   = google_cloudfunctions_function.primary.id
    secondary = google_cloudfunctions_function.secondary.id
  }
  
  cloud_function = each.value
  role           = "roles/cloudfunctions.invoker"
  members        = ["allUsers"]
  
}

