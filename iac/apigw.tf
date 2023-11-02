

resource "google_api_gateway_api" "api_chatbot" {
  provider = google-beta
  api_id = "api-chatbot"
}
resource "google_api_gateway_api_config" "api_config_chatbot" {
  provider   = google-beta
  api = google_api_gateway_api.api_chatbot.api_id
  api_config_id = "api-config-chatbotv4"
  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("../api/gateway/api_ask.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "api_gw_chatbot" {
  display_name = "api-gw-chatbot"
  provider = google-beta
  api_config = google_api_gateway_api_config.api_config_chatbot.id
  gateway_id = "api-gw-chatbot"
  region = "asia-northeast1"
}


resource "google_apikeys_key" "api_key_chatbot" {
  project     = var.project
  name         = "api-key-chatbotv3"
  display_name = "api-key-chatbot"

  restrictions {
    

    api_targets {
      service = google_api_gateway_api.api_chatbot.managed_service
    }
  }
}

output "gateway_uri" {
  value = google_api_gateway_gateway.api_gw_chatbot.gateway_id
}