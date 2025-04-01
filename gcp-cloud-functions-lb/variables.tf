variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "primary_region" {
  description = "Primary region for resources"
  type        = string
  default     = "us-central1"
}

variable "secondary_region" {
  description = "Secondary region for resources"
  type        = string
  default     = "us-west1"
}

variable "function_memory" {
  description = "Memory allocation for Cloud Functions"
  type        = number
  default     = 128
}

variable "enable_public_access" {
  description = "Allow public access to Cloud Functions"
  type        = bool
  default     = true
}