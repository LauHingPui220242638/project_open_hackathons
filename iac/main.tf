terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)

  project = "fyp-open-data-hackathon"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


resource "google_cloud_run_service" "backend" {
  name     = "backend"
  location = "${var.region}"

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}