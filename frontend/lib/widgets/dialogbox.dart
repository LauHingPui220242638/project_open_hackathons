import 'package:flutter/material.dart';
import 'package:frontend/env.dart';
import 'package:frontend/widgets/gmap.dart';

class DialogBox extends StatelessWidget {
  final identity;
  final chat;
  final kind;
  final List<double> coordinates;
  

  const DialogBox({
    Key? key,
    required this.identity,
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
          crossAxisAlignment: identity == "AI" ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$identity : $chat',
              // overflow:Wrap(),
              textAlign: identity == "AI" ? TextAlign.right : TextAlign.left,
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
