resource "google_service_account" "function_sa" {
  account_id   = "hello-function-sa"
  display_name = "Cloud Function Service Account"
}
