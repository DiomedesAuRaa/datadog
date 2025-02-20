# Datadog Monitoring with Terraform

This repository contains Terraform configurations for setting up Datadog integrations to monitor:

- **AWS Services**: EC2, EKS, RDS, S3
- **Azure Services**: AKS, Virtual Machines, Azure SQL, Blob Storage
- **GCP Services**: GKE, Compute Engine, Cloud SQL, BigQuery

## Prerequisites
- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Obtain Datadog API and App keys from your Datadog account.

## Deploying Monitoring
1. Navigate to the environment (`dev` or `prod`):
   ```sh
   cd environments/dev
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Apply the configuration:
   ```sh
   terraform apply -auto-approve
   ```
4. The output will display the integration status.

## Selective Integration
To enable or disable specific integrations, pass the appropriate variables. For example, to only enable AWS and GCP integrations:
```sh
terraform apply \
  -var="enable_aws_integration=true" \
  -var="enable_azure_integration=false" \
  -var="enable_gcp_integration=true"
```

## Destroying Resources
```sh
terraform destroy -auto-approve
```
Run this in the environment directory.

