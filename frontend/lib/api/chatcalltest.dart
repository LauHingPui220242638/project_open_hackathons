import 'dart:convert';
import 'package:frontend/env.dart' as env;
import 'package:http/http.dart' as http;

Future<void> main() async {
  const user_id = "Leo";
  const chat = "HIHIHI";
  const BACKEND_URL = "localhost:8080";
  final data = callTemplate(user_id, chat);
  final response = await callPost(BACKEND_URL, '/ask', data);

  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response.body);

    // final List<Map> data;
    // data = List<Map>.from(body.map((e) => Map.from(e)));
    // String text = data[0]['response'];

    final user_id = body['data']['user_id'];
    final chat = body['data']['chat'];
    final kind = body['data']['kind'];
    final coordinates = body['data']['coordinates'];
    print(body);
  }
}

Future<http.Response> callPost(
  String url,
  String path,
  Map<String, dynamic> data,
) async {
  final body = json.encode(data);
  final api_key = env.API_KEY;
  final query = {'api_key': api_key};

  return http.post(Uri.http(url, path, query),
      headers: {
        "Content-Type": "application/json",
        // "Accept": "application/json",
        // "Access-Control-Request-Method": "POST",
        // "Access-Control-Request-Headers": "Content-Type"
      },
      body: body);
}

Map<String, dynamic> callTemplate(String user_id, String chat) {
  return {
    "user_id": user_id,
    "data": {
      "chat": chat,
      "kind": "text",
      "coordinates": [0.0, 0.0, 0.0],
    }
  };
}
