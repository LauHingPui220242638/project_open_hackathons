
import 'package:frontend/widgets/chatbox.dart'as chatbox ;
import 'package:frontend/env.dart' as env;
import 'package:http/http.dart' as http;
import 'dart:convert';

ask(
    {
      required chatbox.ChatBoxState state,
      required String user,
      required String question
    }) async {
  // final response = await http.get(Uri.parse(url));
  state.addItemToList(user, question);
  
  final data = callTemplate(
    data: {"question": question}
    );
  var body = json.encode(data);
  var url = env.BACKEND_URL;
  final response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Accept": "application/json",
        // "Access-Control-Request-Method": "POST",
        // "Access-Control-Request-Headers": "Content-Type"
      },
      body: body);

  if (response.statusCode == 200) {
    Map<String,dynamic> body = json.decode(response.body);

    // final List<Map> data;
    // data = List<Map>.from(body.map((e) => Map.from(e)));
    // String text = data[0]['response'];
    
    final ans = body['data']['response'];
    state.addItemToList("AI", ans);
    return ans;
  } else {
    throw Exception('Failed to load');
  }
}

Map<String, dynamic> callTemplate({required dynamic data}) {
  return {
    "api_key": "AIzaSyA5jhZl3dPpOsr5DX4_pCgA4ibI7sDfNOM",
    "data": data,
  };
  
}