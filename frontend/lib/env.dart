const stage = String.fromEnvironment('MODE', defaultValue: 'PROD');
String backendURL = "";



void initApp({String? stage}){
    switch(stage)
  {
      case "DEV":
        backendURL = "https://jsonplaceholder.typicode.com/albums/";
        break;
      default:
        break;
  }
}