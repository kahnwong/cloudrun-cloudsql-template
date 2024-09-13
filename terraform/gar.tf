resource "google_artifact_registry_repository" "this" {
  location      = var.region
  repository_id = "cloud-run-cloud-sql-template"
  format        = "DOCKER"
}
