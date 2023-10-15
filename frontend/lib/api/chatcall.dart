import 'package:frontend/widgets/chatbox.dart' as chatbox;
import 'package:frontend/env.dart' as env;
import 'package:http/http.dart' as http;
import 'dart:convert';

ask(
    {required chatbox.ChatBoxState state,
    required String user_id,
    required String question}) async {
  state.addItemToList(user_id, question);
  final data = callTemplate(user_id,{"question": question});
  final response = await callPost(env.BACKEND_URL,'/ask',data);

  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response.body);

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


 

Future<http.Response> callPost(  
  String url,
  String path,
  Map<String, dynamic> data,
  
  ) async {
  
  final body = json.encode(data);
  final api_key = env.API_KEY;
  final query = {
    'api_key':api_key
  };

 
  return http.post(Uri.https(url,path,query),
      headers: {
        "Content-Type": "application/json",
        // "Accept": "application/json",
        // "Access-Control-Request-Method": "POST",
        // "Access-Control-Request-Headers": "Content-Type"
      },
      body: body);

}

Map<String, dynamic> callTemplate(String user_id, Map<String,dynamic> data) {
  return {
    "user_id": user_id,
    "data": data,
  };
}
