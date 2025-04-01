# Backend Service with Failover
resource "google_compute_backend_service" "default" {
  name                  = "hello-world-backend"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30

  # Primary Region Backend
  backend {
    group                 = google_compute_region_network_endpoint_group.primary_neg.id
    
  }

  # Failover Backend
  backend {
    group                 = google_compute_region_network_endpoint_group.secondary_neg.id
    
  }

  outlier_detection {
    base_ejection_time {
      seconds = 30
    }
    consecutive_errors = 5 # Eject after 5 consecutive 5xx errors
  }
}

# URL Map
resource "google_compute_url_map" "default" {
  name            = "hello-world-url-map"
  default_service = google_compute_backend_service.default.id
}

# HTTP Proxy (Not HTTPS)
resource "google_compute_target_http_proxy" "default" {
  name    = "hello-world-http-proxy"
  url_map = google_compute_url_map.default.id
}

# Global Forwarding Rule (Port 80)
resource "google_compute_global_forwarding_rule" "http" {
  name                  = "hello-world-http-lb"
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}