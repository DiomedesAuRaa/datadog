module "aws" {
  count  = var.enable_aws_integration ? 1 : 0
  source = "../../modules/aws"
}

module "azure" {
  count  = var.enable_azure_integration ? 1 : 0
  source = "../../modules/azure"
}

module "gcp" {
  count  = var.enable_gcp_integration ? 1 : 0
  source = "../../modules/gcp"
}
