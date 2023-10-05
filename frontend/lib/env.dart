const stage = String.fromEnvironment('MODE', defaultValue: 'PROD');
String backendURL = "https://expert-space-cod-v97566x4p7qcwgqw-8080.app.github.dev/ask";



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