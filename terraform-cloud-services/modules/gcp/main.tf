resource "datadog_integration_gcp" "gcp" {
  count         = var.enable_gcp_integration ? 1 : 0
  project_id     = "my-gcp-project" # Replace with your GCP project ID
  private_key_id = "my-private-key-id" # Replace with your GCP private key ID
  private_key    = "my-private-key"    # Replace with your GCP private key
  client_email   = "my-client-email"   # Replace with your GCP client email
  client_id      = "my-client-id"      # Replace with your GCP client ID
  host_filters   = "env:prod"
}

# Monitor GKE clusters
resource "datadog_monitor" "gke_memory_usage" {
  count   = var.enable_gcp_integration ? 1 : 0
  name    = "High Memory Usage on GKE Cluster"
  type    = "metric alert"
  query   = "avg(last_5m):avg:kubernetes.memory.usage{cluster_name:my-gke-cluster} by {pod_name} > 80"
  message = "High memory usage detected on GKE cluster."
}
