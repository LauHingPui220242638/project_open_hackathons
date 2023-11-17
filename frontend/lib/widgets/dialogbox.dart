import 'package:flutter/material.dart';
import 'package:frontend/env.dart';
import 'package:frontend/widgets/gmap.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DialogBox extends StatefulWidget {
  final user_id;
  final chat;
  final kind;
  final coordinates;
  

  DialogBox({
    Key? key,
    required this.user_id,
    required this.chat,
    required this.kind,
    required this.coordinates ,
  }): super(key: key);

  _DialogBoxState createState() => _DialogBoxState();
}


class _DialogBoxState extends State<DialogBox> with AutomaticKeepAliveClientMixin{
  
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final mWdith = MediaQuery.of(context).size.width;
    final userId = widget.user_id;
    final chat = widget.chat;
    final kind = widget.kind;
    final coordinates = widget.coordinates;
    
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: mWdith * 0.8),
        decoration: userId == "AI" ? const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ROUNDED_CORNER_GLOBAL),
            topRight: Radius.circular(ROUNDED_CORNER_GLOBAL),
            bottomLeft: Radius.circular(ROUNDED_CORNER_GLOBAL),
            bottomRight: Radius.zero,
          ),
          color: Colors.indigo,
        ):const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ROUNDED_CORNER_GLOBAL),
            topRight: Radius.circular(ROUNDED_CORNER_GLOBAL),
            bottomLeft: Radius.zero,
            bottomRight: Radius.circular(ROUNDED_CORNER_GLOBAL),
          ),
          color: Colors.indigo,
        ),
        child: Column(
          crossAxisAlignment: userId == "AI" ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [TyperAnimatedText(
                '$userId : $chat',
                // overflow:Wrap(),
                
                textAlign: userId == "AI" ? TextAlign.right : TextAlign.left,
                textStyle: TextStyle(
                  letterSpacing: 0.001,
                  fontSize: mWdith * 0.05,
                  color: Colors.lightBlue,
                  // fontFamily:''
                ),
              )
              ],
            ),
            kind == "map" ? GMap(coordinates: coordinates) : Container(),
          ],
        ),
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}