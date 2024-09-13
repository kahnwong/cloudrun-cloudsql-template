# ---------------- database instance ---------------- #
#tfsec:ignore:google-sql-encrypt-in-transit-data
#tfsec:ignore:google-sql-no-public-access
resource "google_sql_database_instance" "this" {
  name             = "cloud-run-cloud-sql-template"
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    user_labels = {
      project = var.project_id
    }

    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true # need this for cloud auth proxy
      #      enable_private_path_for_google_cloud_services = true

      #      authorized_networks {
      #        name  = "allow-all"
      #        value = "0.0.0.0/0"
      #      }
    }

    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }

    database_flags {
      name  = "log_disconnections"
      value = "on"
    }

    database_flags {
      name  = "log_lock_waits"
      value = "on"
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }

    database_flags {
      name  = "log_temp_files"
      value = "0"
    }

    database_flags {
      name  = "max_connections"
      value = "150"
    }

    backup_configuration {
      enabled = false
    }

    insights_config {
      query_insights_enabled = true
    }
  }

  deletion_protection = true
}

resource "random_password" "admin_user" {
  length           = 16
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
resource "google_sql_user" "development_admin_user" {
  instance = google_sql_database_instance.this.name
  name     = "development_admin"
  password = random_password.admin_user.result
}
