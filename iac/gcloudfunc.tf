locals {
  project = var.project
}

resource "google_storage_bucket" "gcloudfunc-chatbot-bucket" {
  name     = "${local.project}-gcloudfunc-chatbot-bucket"  # Every bucket name must be globally unique
  location = var.region
  uniform_bucket_level_access = true
}

data "archive_file" "chatbot-zip" {
  type        = "zip"
  source_dir  = "../api/gfunc/chatbot"
  output_path = "../api/gfunc/chatbot.zip"
}


resource "google_storage_bucket_object" "gcloudfunc-chatbot-source" {
    depends_on = [data.archive_file.chatbot-zip]
    name   = "gcloudfunc-chatbot-source.zip"
    bucket = google_storage_bucket.gcloudfunc-chatbot-bucket.name
    source = "../api/gfunc/chatbot.zip"
}


resource "google_cloudfunctions2_function" "gcloudfunc-chatbot" {
  name = "gcloudfunc-chatbot"
  location = var.region
  description = "Google Cloud Function Chatbot"

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
    max_instance_count  = 1
    available_memory    = "256M"
    timeout_seconds     = 60
  }
}

output "gcloudfunc-chatbot-uri" { 
  value = google_cloudfunctions2_function.gcloudfunc-chatbot.service_config[0].uri
}
