output "gcloudfunc-chatbot-uri" { 
  value = google_cloudfunctions2_function.gcloudfunc-chatbot.service_config[0].uri
}
