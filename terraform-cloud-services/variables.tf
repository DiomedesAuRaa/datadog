variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog App key"
  type        = string
  sensitive   = true
}

variable "enable_aws_integration" {
  description = "Enable Datadog AWS integration"
  type        = bool
  default     = true
}

variable "enable_azure_integration" {
  description = "Enable Datadog Azure integration"
  type        = bool
  default     = true
}

variable "enable_gcp_integration" {
  description = "Enable Datadog GCP integration"
  type        = bool
  default     = true
}

variable "datadog_agent_version" {
  description = "Version of the Datadog Agent to deploy"
  type        = string
  default     = "7"
}
