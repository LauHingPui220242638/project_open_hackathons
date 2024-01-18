import 'package:file_picker/file_picker.dart';
import 'package:frontend/widgets/chatbox.dart' as chatbox;
import 'package:frontend/env.dart' as env;
import 'package:http/http.dart' as http;
import 'dart:convert';

ask(
    {required chatbox.ChatBoxState state,
    required String user_id,
     required Map<String, dynamic> inputdata,
    }) async {
      
  String chat = inputdata['chat'];
  String kind = inputdata['kind'];
  FilePickerResult? image = inputdata['image'];
  
  state.addItemToList( user_id,{"chat":chat,"kind": kind, "image":image});
  
  final data = callTemplate(user_id,chat);
  final response = await callPost(env.BACKEND_URL,'/ask',data);

  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response.body);
    print(body);

    // final List<Map> data;
    // data = List<Map>.from(body.map((e) => Map.from(e)));
    // String text = data[0]['response'];

    final userId = body['user_id'];
    final data = body['data'];
    final chat = data['chat'];
    data['coordinates'] = (data['coordinates'] as List).map((item) => item as double).toList();
    state.addItemToList(userId, data);
    state.setScollingStart(true);
    state.scrollDown();

    return chat;
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
  final apiKey = env.API_KEY;
  final query = {
    'api_key':apiKey
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

Map<String, dynamic> callTemplate(String userId, String chat) {
  return {
    "user_id": userId,
    "data": {
      "chat": chat,
      "kind": "text",
      "coordinates": [0.0,0.0,0.0],
    }
  };
}
