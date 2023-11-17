import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/chatbox.dart';
import 'package:frontend/api/chatcall.dart' as chatcall;

class PageHome extends StatefulWidget {
  const PageHome({Key? key, required this.chatboxgkey}) : super(key: key);

  final GlobalKey chatboxgkey;

  @override
  PageHomeState createState() => PageHomeState();
}

class PageHomeState extends State<PageHome> with AutomaticKeepAliveClientMixin<PageHome> {
  final textcontroller = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    late final focusNode = FocusNode(
      onKeyEvent: (node, event) {
        final enterPressedWithoutShift = event is KeyDownEvent &&
            event.physicalKey == PhysicalKeyboardKey.enter &&
            !HardwareKeyboard.instance.physicalKeysPressed.any(
              (key) => <PhysicalKeyboardKey>{
                PhysicalKeyboardKey.shiftLeft,
                PhysicalKeyboardKey.shiftRight,
              }.contains(key),
            );

        if (enterPressedWithoutShift) {
          final state = chatboxgkey.currentState!;
          final chat = textcontroller.text;
          print(chat);
          chatcall.ask(
            state: state,
            user_id: user_id,
            chat: chat,
          );
          textcontroller.clear();
          return KeyEventResult.handled;
        } else if (event is KeyRepeatEvent) {
          // Disable holding enter
          return KeyEventResult.handled;
        } else {
          print("@@@@");
          return KeyEventResult.ignored;
        }
      },
    );
    double fontSize = 40;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(child: Expanded(child: ChatBox(key: widget.chatboxgkey))),
          // Spacer(),
          Container(
            child: TextFormField(
              autofocus: true,
              controller: textcontroller,
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.primaries[0],
              ),
              decoration: const InputDecoration(
                hintText: 'Ask Something',
                hintStyle: TextStyle(
                    fontSize: 40, color: Color.fromARGB(88, 207, 175, 79)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
