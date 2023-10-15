import 'package:flutter/material.dart';
import 'package:frontend/widgets/chatbox.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key, required this.chatboxgkey}) : super(key: key);

  final GlobalKey chatboxgkey;

  @override
  PageHomeState createState() => PageHomeState();
}

class PageHomeState extends State<PageHome>  with AutomaticKeepAliveClientMixin<PageHome>{
  final textcontroller = TextEditingController();
  
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          Container(
            child: Expanded(
              child: ChatBox(key: widget.chatboxgkey))),
          // Spacer(),
          Container(
              child: TextFormField(
                  controller: textcontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Ask Something',
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),
          
            ),
          
        ],
      ),
    );
  }
}


