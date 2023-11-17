

resource "google_api_gateway_api" "api_chatbot" {
  provider = google-beta
  display_name = "API Chatbot"
  api_id = "api-chatbot"
}
resource "google_api_gateway_api_config" "api_config_chatbot" {
  provider   = google-beta
  api = google_api_gateway_api.api_chatbot.api_id
  api_config_id = "api-config-chatbotv6"
  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("../api/gateway/api_ask.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  gateway_config {
    backend_config {
      google_service_account = google_service_account.sa_api_gw_chatbot.email
    }
  }
}

resource "google_api_gateway_gateway" "api_gw_chatbot" {
  display_name = "API Chatbot Gateway"
  provider = google-beta
  api_config = google_api_gateway_api_config.api_config_chatbot.id
  gateway_id = "api-gw-chatbot"
  region = "asia-northeast1"
}


resource "google_apikeys_key" "api_key_chatbot" {
  project     = var.project
  name         = "api-key-chatbotv4"
  display_name = "api-key-chatbot"

  restrictions {
    

    api_targets {
      service = google_api_gateway_api.api_chatbot.managed_service
    }
  }
}

resource "google_service_account" "sa_api_gw_chatbot" {
  project = var.project
  account_id   = "sa-api-gw-chatbot"
  display_name = "sa-api-gw-chatbot"
}


resource "google_project_iam_member" "api_gw_policy_role" {
  project = var.project
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.sa_api_gw_chatbot.email}"
}

resource "google_project_iam_member" "api_gw_policy_role2" {
  project = var.project
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.sa_api_gw_chatbot.email}"
}



output "gateway_uri" {
  value = google_api_gateway_gateway.api_gw_chatbot.gateway_id
}


# gcloud api-gateway api-configs describe api-config-chatbotv6 \
#   --api="api-chatbot"