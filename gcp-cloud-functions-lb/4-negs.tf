# Primary Region NEG
resource "google_compute_region_network_endpoint_group" "primary_neg" {
  name                  = "hello-primary-neg"
  region                = "us-central1"
  network_endpoint_type = "SERVERLESS"
  
  cloud_function {
    function = google_cloudfunctions_function.primary.name
  }
}

# Secondary Region NEG
resource "google_compute_region_network_endpoint_group" "secondary_neg" {
  name                  = "hello-secondary-neg"
  region                = "us-west1"
  network_endpoint_type = "SERVERLESS"
  
  cloud_function {
    function = google_cloudfunctions_function.secondary.name
  }
}