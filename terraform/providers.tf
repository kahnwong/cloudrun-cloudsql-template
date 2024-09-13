provider "github" {
  token = var.github_token
  owner = var.github_org
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
