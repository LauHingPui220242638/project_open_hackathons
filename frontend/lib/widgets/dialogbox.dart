import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final identity;
  final chat;

  const DialogBox({
    super.key,
    required this.identity,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final mWdith = MediaQuery.of(context).size.width;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(mWdith * 0.005),
          constraints: BoxConstraints(maxWidth: mWdith*0.8),

          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.amber,
          ),
          child:Text(
              '$identity : $chat',
              // overflow:Wrap(),
              textAlign: identity == "AI" ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                letterSpacing: 0.001,
                fontSize: mWdith*0.05,
                color: Colors.black,
                // fontFamily:''
              ),
            ),
            
            
            
            
            
          ),
    );
  }
}
