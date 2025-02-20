output "aws_integration_status" {
  value = var.enable_aws_integration ? "AWS integration enabled" : "AWS integration disabled"
}

output "azure_integration_status" {
  value = var.enable_azure_integration ? "Azure integration enabled" : "Azure integration disabled"
}

output "gcp_integration_status" {
  value = var.enable_gcp_integration ? "GCP integration enabled" : "GCP integration disabled"
}
