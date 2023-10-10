import 'package:flutter/material.dart';
import 'dialogbox.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  State<ChatBox> createState() => ChatBoxState();
}

class ChatBoxState extends State<ChatBox> {
  List<Map> dialog = [
    {'identity': 'Leo', 'chat': 'ask some quest'},
    {'identity': 'AI', 'chat': 'answer some content'},
    {'identity': 'Leo', 'chat': 'ask some map'},
    {'identity': 'AI', 'chat': 'reponse google map'},
  ];

  @override
  void initState() {
    super.initState();
    addItemToList("Leo", "AAA\ndsadsa\nJSIDJISO\nJIOSDJIAS");
    addItemToList("AI", "AAA\ndsadsa\nJSIDJISO\nJIOSDJIAS");
    addItemToList("Leo", "AAA");
    addItemToList("AI", "KKK");
    addItemToList("Leo", "AAAL");
    addItemToList("AI", "KKKL");
    addItemToList("Leo", "AAAL");
    addItemToList("AI", "KKKL");
    addItemToList("Leo", "AAALL");
    addItemToList("AI", "KKKLL");
  }

  final ScrollController controller = ScrollController();

  void addItemToList(String identity, String chat) {
    setState(() {
      dialog.insert(dialog.length, {'identity': identity, 'chat': chat});
    });
  }
// https://stackoverflow.com/questions/51029655/call-method-in-one-stateful-widget-from-another-stateful-widget-flutter

  @override
  Widget build(BuildContext context) {
    final mWdith = MediaQuery.of(context).size.width;

    return ListView.builder(
        controller: controller,
        // padding: const EdgeInsets.all(8),
        itemCount: dialog.length,
        itemBuilder: (context, index) {
          final identity = dialog[index]['identity'];
          final chat = dialog[index]['chat'];
          return Align(
            alignment:
                identity == "AI" ? Alignment.centerRight : Alignment.centerLeft,
            child: DialogBox(
              identity: identity,
              chat: chat,
            ),
          );
        });
  }
}
