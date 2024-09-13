resource "google_cloud_run_service" "this" {
  name = "cloud-run-cloud-sql-template"

  location = var.region
  project  = var.project_id

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"         = "100"
        "run.googleapis.com/client-name"           = "cloud-console"
        "run.googleapis.com/cloudsql-instances"    = google_sql_database_instance.this.connection_name
        "run.googleapis.com/execution-environment" = "gen2"
        "run.googleapis.com/startup-cpu-boost"     = "true"
      }
    }
    spec {
      container_concurrency = 80
      service_account_name  = "732645474125-compute@developer.gserviceaccount.com"
      timeout_seconds       = 300

      containers {
        image = "asia-southeast1-docker.pkg.dev/xxxxxxx/cloud-run-cloud-sql-template/cloud-run-cloud-sql-template:4cba31d"

        env {
          name  = "POSTGRES_HOSTNAME"
          value = "/cloudsql/${google_sql_database_instance.this.connection_name}"
        }
        env {
          name  = "POSTGRES_USERNAME"
          value = google_sql_user.development_admin_user.name
        }
        env {
          name  = "POSTGRES_PASSWORD"
          value = random_password.admin_user.result
        }
        env {
          name  = "POSTGRES_DBNAME"
          value = "postgres"
        }
        env {
          name  = "POSTGRES_PORT"
          value = "5432"
        }


        liveness_probe {
          failure_threshold     = 3
          initial_delay_seconds = 0
          period_seconds        = 10
          timeout_seconds       = 1

          http_get {
            path = "/version"
            port = 8080
          }
        }

        ports {
          container_port = 8080
          name           = "http1"
        }

        resources {
          limits = {
            "cpu"    = "1"
            "memory" = "1G"
          }
          requests = {}
        }

        startup_probe {
          failure_threshold     = 1
          initial_delay_seconds = 0
          period_seconds        = 240
          timeout_seconds       = 240

          tcp_socket {
            port = 8080
          }
        }
      }
    }
  }
}

#resource "google_cloud_run_service_iam_binding" "this" { # had to do it by hand
#  location = google_cloud_run_service.this.location
#  project  = google_cloud_run_service.this.project
#  service  = google_cloud_run_service.this.name
#
#  role = "roles/run.invoker"
#  members = [
#    "allUsers",
#  ]
#}
