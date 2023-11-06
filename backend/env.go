package main

import (
	"os"
)

var BACKEND_ENV string = os.Getenv("CHATBOT_BACKEND_MODE")
var GATEWAY_URL string = "https://api-gw-chatbot-7923qjyk.an.gateway.dev"