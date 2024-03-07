
resource "google_storage_bucket" "gcloudfunc-chatbot-bucket" {
  name     = "${var.project}-gcloudfunc-${var.name}-bucket"  # Every bucket name must be globally unique
  location = var.region
  uniform_bucket_level_access = true
}

data "archive_file" "chatbot-zip" {
  type        = "zip"
  source_dir  = "../api/gfunc/${var.name}"
  output_path = "../api/gfunc/${var.name}.zip"
}


resource "google_storage_bucket_object" "gcloudfunc-chatbot-source" {
    depends_on = [data.archive_file.chatbot-zip]
    name   = "gcloudfunc-chatbot-source-${data.archive_file.chatbot-zip.output_md5}.zip"
    bucket = google_storage_bucket.gcloudfunc-chatbot-bucket.name
    source = "../api/gfunc/${var.name}.zip"
}


resource "google_cloudfunctions2_function" "gcloudfunc-chatbot" {
  name = "gcloudfunc-${var.name}"
  location = var.region
  description = "Google Cloud Function Chatbot for ${var.name}"

  build_config {
    runtime = "python311"
    entry_point = "ask"  
    source {
      storage_source {
        bucket = google_storage_bucket.gcloudfunc-chatbot-bucket.name
        object = google_storage_bucket_object.gcloudfunc-chatbot-source.name
      }
    }
  }

  service_config {
    available_memory    = "1Gi"
    timeout_seconds     = 60
    available_cpu = "1"
    min_instance_count = 0
    max_instance_count = 5
    max_instance_request_concurrency = 10
    
    service_account_email = google_service_account.gcloudfunc-chatbot-account.email
  }
}




resource "google_service_account" "gcloudfunc-chatbot-account" {
  account_id = "${var.name}-sa"
  display_name = "ChatBot Service Account for ${var.name}"
}

resource "google_project_iam_member" "gcloudfunc-chatbot_policy_role" {
  project = var.project
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.gcloudfunc-chatbot-account.email}"
}
