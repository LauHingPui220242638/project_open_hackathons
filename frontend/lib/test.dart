

import 'package:http/http.dart' as http;
import 'package:frontend/env.dart' as env;


import 'dart:convert';

String url = "http://localhost:8080/ask";
Map data = {"question":"How are me?"};
var body = jsonEncode(data);

void main() {
  
  // final reponse = html.HttpRequest.request(
  //   url,
  //   method: 'POST',
  //   // the Map has to be encoded using jsonEncode
  //   sendData: data,
  // );
  final response =  http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin":"*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers": "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With"
      },
    body: body
  );

  // final reponse = http.get(
  //   Uri.parse(url)
  // );
}


