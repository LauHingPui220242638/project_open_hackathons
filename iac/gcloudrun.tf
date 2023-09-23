
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
  location      = "asia-east1"
  format        = "docker"
}


resource "google_cloud_run_service" "cloud-run-backend" {
  name = "cloudrun-backend"
  location = var.region

  template {
	spec {
  	containers {
        image = "asia-east1-docker.pkg.dev/fyp-open-data-hackathon/backend/backend:latest"
      }
    }
  }
}