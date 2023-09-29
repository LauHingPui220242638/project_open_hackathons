
# resource "google_cloudbuild_trigger" "trigger-backend" {
#   location = var.region

#   github {
#     owner = "hashicorp"
#     name  = "terraform-provider-google-beta"
#     push {
#       branch = "^main$"
#     }
#   }

#   included_files = ["/backend/**"]

#   filename = "cloudbuild-backend.yaml"
# }



resource "google_artifact_registry_repository" "artifact-registry-cloudrun" {
  repository_id = "cloudrun"
  location      = var.region
  format        = "docker"
}


resource "google_cloud_run_service" "default" {
  name     = "cloudrun-backend"
  location = var.region

  
  
    template {
    spec {
   
      containers {
      image = "asia-east1-docker.pkg.dev/fyp-open-data-hackathon/backend/backend:latest"
      }
    }
    metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale"      = "1"
      }
    }
  }
  
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}