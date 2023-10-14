package main

import "os"

var BACKEND_ENV string = os.Getenv("CHATBOT_BACKEND_MODE")
var LANCHAIN_GATEWAY_URL string = "https://api-gateway-7923qjyk.ue.gateway.dev"