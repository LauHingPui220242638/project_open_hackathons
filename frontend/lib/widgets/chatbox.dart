import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dialogbox.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  State<ChatBox> createState() => ChatBoxState();
}

class ChatBoxState extends State<ChatBox> {
  List<Map> dialog = [];
  bool _scrollingStart = true;
  double _scrollingpos = 0.0;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    addItemToList("Leo", {"chat": "Hello, Who are you?", "kind": "text"});
    addItemToList(
        "AI", {"chat": "Hello I am your AI assistant", "kind": "text"});
    addItemToList("Leo",
        {"chat": "I Want to know about The Event Location", "kind": "text"});
    addItemToList("AI", {
      "chat": "Hello Here is Map of your location",
      "kind": "map",
      "coordinates": [22.3058312, 114.253163, 15.0]
    });
    addItemToList("AI", {
      "chat": "Another Location",
      "kind": "map",
      "coordinates": [22.195671, 113.54797, 16.0]
    });
  }

  void setScollingStart(bool value) {
    setState(() {
      _scrollingStart = value;

    });
  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  void addItemToList(String userId, Map<String, dynamic> data) {
    setState(() {
      dialog.insert(dialog.length, {
        'user_id': userId,
        'data': data,
      });
    });
  }
// https://stackoverflow.com/questions/51029655/call-method-in-one-stateful-widget-from-another-stateful-widget-flutter

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {


        if (_scrollingpos <= notification.metrics.extentBefore) {

        } else {
          setScollingStart(false);

        }
        _scrollingpos = notification.metrics.extentBefore;

        if (notification.metrics.extentAfter > 12 && _scrollingStart == true) {
          scrollDown();
        }
        return true;
      },
      child: ListView.builder(
          addAutomaticKeepAlives: true,
          controller: scrollController,
          // padding: const EdgeInsets.all(8),
          itemCount: dialog.length,
          itemBuilder: (context, index) {
            final userId = dialog[index]['user_id'];
            final data = dialog[index]['data'];
            final chat = data['chat'];
            final kind = data['kind'];
            final coordinates = data['coordinates'];
            return Align(
              alignment:
                  userId == "AI" ? Alignment.centerRight : Alignment.centerLeft,
              child: DialogBox(
                user_id: userId,
                chat: chat,
                kind: kind,
                coordinates: coordinates,
              ),
            );
          }),
    );
  }
}
