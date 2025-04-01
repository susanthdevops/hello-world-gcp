module "audit_logs" {
  source = "./modules/audit-logs"

  bucket_name            = "hello-audit-logs"
  sink_name              = "audit-logs-sink"
  filter                 = "logName:\"cloudaudit.googleapis.com\""
  exclusion_name         = "exclude-data-access-logs"
  exclusion_description  = "Exclude data access logs from being exported."
  exclusion_filter       = "logName:\"cloudaudit.googleapis.com/data_access\""
}