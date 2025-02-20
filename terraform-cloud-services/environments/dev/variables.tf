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
  default = true
}

variable "enable_azure_integration" {
  default = true
}

variable "enable_gcp_integration" {
  default = true
}

variable "datadog_agent_version" {
  default = "7"
}
