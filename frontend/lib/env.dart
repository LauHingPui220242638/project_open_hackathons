const stage = String.fromEnvironment('CHATBOT_FRONTEND_MODE', defaultValue: 'PROD');


String BACKEND_URL = "cloudrun-backend-qskzidtbhq-de.a.run.app";
String API_KEY = "AIzaSyA5jhZl3dPpOsr5DX4_pCgA4ibI7sDfNOM";

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