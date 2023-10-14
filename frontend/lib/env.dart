const stage = String.fromEnvironment('CHATBOT_FRONTEND_MODE', defaultValue: 'PROD');
String BACKEND_URL = "https://cloudrun-backend-qskzidtbhq-de.a.run.app/ask";



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