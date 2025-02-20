resource "datadog_integration_azure" "azure" {
  count         = var.enable_azure_integration ? 1 : 0
  tenant_name   = "my-azure-tenant" # Replace with your Azure tenant name
  client_id     = "my-client-id"    # Replace with your Azure client ID
  client_secret = "my-client-secret" # Replace with your Azure client secret
  host_filters  = "env:prod"
}

# Monitor AKS clusters
resource "datadog_monitor" "aks_pod_restarts" {
  count   = var.enable_azure_integration ? 1 : 0
  name    = "High Pod Restarts on AKS Cluster"
  type    = "metric alert"
  query   = "sum(last_5m):sum:kubernetes.restarts{cluster_name:my-aks-cluster} by {pod_name} > 5"
  message = "High pod restarts detected on AKS cluster."
}
