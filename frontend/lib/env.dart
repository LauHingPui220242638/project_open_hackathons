const stage = String.fromEnvironment('CHATBOT_FRONTEND_MODE', defaultValue: 'PROD');


String BACKEND_URL = "cloudrun-backend-qskzidtbhq-de.a.run.app";
String API_KEY = "AIzaSyDdhMPubp8gw0GIzVnGMzG7bAWAGNuvwlM";
const double ROUNDED_CORNER_GLOBAL = 25.0;

void initApp({String? stage}){
    switch(stage)
  {
      case "DEV":
        BACKEND_URL = "http://localhost:8080";
        break;
      default:
        break;
  }
}