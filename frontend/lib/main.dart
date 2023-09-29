import 'package:frontend/pages/pagehome.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottomsticky.dart';
import 'package:frontend/widgets/chatbox.dart' as chatbox;
import 'package:frontend/pages/pagehome.dart' as pagehome;

void main() {
  runApp(ChatApp());
}

const userIdentity = "Leo";
final chatboxgkey =  GlobalKey<chatbox.ChatBoxState>();
final homekey =  GlobalKey<pagehome.PageHomeState>();


class ChatApp extends StatefulWidget {
  ChatApp({Key? key}) : super(key: key);
  
  
  final List<Widget> bodyItems = [
    Center(
      child: PageHome(key: homekey, chatboxgkey: chatboxgkey),
    ),
    const Center(
      child: Sticky(),
    ),
  ];

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  int currentIndex = 0;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('$userIdentity\'s Chat')),
        body: widget.bodyItems[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(label: 'Section A', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Section B', icon: Icon(Icons.settings)),
          ],
          onTap: (index) => {setState(() => currentIndex = index)},
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print("adding item");
              final state = chatboxgkey.currentState!;
              final controller = state.controller;
              
              controller.animateTo(

                  controller.position.maxScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastLinearToSlowEaseIn,
              );
              
              final homestate = homekey.currentState!;
              final textcontroller = homestate.textcontroller;
              
              print(textcontroller.text);
              state.addItemToList(userIdentity,textcontroller.text);
              
            },
      ),
    )
    );
    
  }
}
