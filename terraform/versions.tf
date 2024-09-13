terraform {
  required_version = ">= 1.2.7"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.37.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.82.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
