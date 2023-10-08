const stage = String.fromEnvironment('MODE', defaultValue: 'PROD');
String backendURL = "https://cloudrun-backend-qskzidtbhq-de.a.run.app/ask";



void initApp({String? stage}){
    switch(stage)
  {
      case "DEV":
        backendURL = "http://localhost:8080";
        break;
      default:
        break;
  }
}