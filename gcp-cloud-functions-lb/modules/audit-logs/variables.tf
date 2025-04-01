variable "bucket_name" {
  description = "Name for audit logs bucket"
  type        = string
}

variable "location" {
  description = "Bucket location"
  type        = string
  default     = "US"
}

variable "sink_name" {
  description = "Name for logging sink"
  type        = string
}

variable "filter" {
  description = "Log filter"
  type        = string
}

variable "exclusion_name" {
  description = "Name for log exclusion"
  type        = string
}

variable "exclusion_description" {
  description = "Description for log exclusion"
  type        = string
}

variable "exclusion_filter" {
  description = "Filter for log exclusion"
  type        = string
}