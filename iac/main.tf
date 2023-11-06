# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "4.83.0"
#     }
#   }
# }

provider "google" {
  credentials = file(var.credentials)

  project = "fyp-open-data-hackathon"
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  credentials = file(var.credentials)

  project = "fyp-open-data-hackathon"
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

# resource "google_project_service" "project" {
#   for_each = toset(var.list_services)
#   project = var.project
#   service = each.key
# }
resource "google_project_service" "project" {
  project = var.project
  service = google_api_gateway_api.api_chatbot.managed_service
}