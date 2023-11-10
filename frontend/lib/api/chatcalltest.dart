import 'dart:convert';
import 'package:frontend/env.dart' as env;
import 'package:http/http.dart' as http;

Future<void> main() async {
  const userId = "Leo";
  const chat = "HIHIHI";
  const backendUrl = "localhost:8080";
  final data = callTemplate(userId, chat);
  final response = await callPost(backendUrl, '/ask', data);

  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response.body);

    // final List<Map> data;
    // data = List<Map>.from(body.map((e) => Map.from(e)));
    // String text = data[0]['response'];

    final userId = body['data']['user_id'];
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
  final apiKey = env.API_KEY;
  final query = {'api_key': apiKey};

  return http.post(Uri.http(url, path, query),
      headers: {
        "Content-Type": "application/json",
        // "Accept": "application/json",
        // "Access-Control-Request-Method": "POST",
        // "Access-Control-Request-Headers": "Content-Type"
      },
      body: body);
}

Map<String, dynamic> callTemplate(String userId, String chat) {
  return {
    "user_id": userId,
    "data": {
      "chat": chat,
      "kind": "text",
      "coordinates": [0.0, 0.0, 0.0],
    }
  };
}
