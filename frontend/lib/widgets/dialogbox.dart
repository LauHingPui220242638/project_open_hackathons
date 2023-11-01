import 'package:flutter/material.dart';
import 'package:frontend/env.dart';
import 'package:frontend/widgets/gmap.dart';

class DialogBox extends StatelessWidget {
  final user_id;
  final chat;
  final kind;
  final List<double> coordinates;
  

  const DialogBox({
    Key? key,
    required this.user_id,
    required this.chat,
    required this.kind,
    required this.coordinates ,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final mWdith = MediaQuery.of(context).size.width;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.all(mWdith * 0.01),
        constraints: BoxConstraints(maxWidth: mWdith * 0.8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ROUNDED_CORNER_GLOBAL)),
          color: Colors.indigo,
        ),
        child: Column(
          crossAxisAlignment: user_id == "AI" ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$user_id : $chat',
              // overflow:Wrap(),
              textAlign: user_id == "AI" ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                letterSpacing: 0.001,
                fontSize: mWdith * 0.05,
                color: Colors.lightBlue,
                // fontFamily:''
              ),
            ),
            kind == "map" ? GMap(coordinates: coordinates) : Container(),
          ],
        ),
      ),
    );
  }
}
