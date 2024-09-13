# Cloud Run & Cloud SQL Template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.7 |
| github | 5.37.0 |
| google | 4.82.0 |
| random | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| google | 4.82.0 |
| random | 3.5.1 |

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.this](https://registry.terraform.io/providers/hashicorp/google/4.82.0/docs/resources/artifact_registry_repository) | resource |
| [google_cloud_run_service.this](https://registry.terraform.io/providers/hashicorp/google/4.82.0/docs/resources/cloud_run_service) | resource |
| [google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google/4.82.0/docs/resources/sql_database_instance) | resource |
| [google_sql_user.development_admin_user](https://registry.terraform.io/providers/hashicorp/google/4.82.0/docs/resources/sql_user) | resource |
| [random_password.admin_user](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github\_org | n/a | `string` | n/a | yes |
| github\_token | need for github auth | `string` | n/a | yes |
| project\_id | n/a | `string` | n/a | yes |
| region | The region of resources | `string` | `"asia-southeast1"` | no |
| zone | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
