import 'package:flutter/material.dart';
import 'package:frontend/env.dart' as env;


import 'package:frontend/pages/pagehome.dart';
import 'package:frontend/pages/pagehome.dart' as pagehome;
import 'package:frontend/widgets/chatbox.dart' as chatbox;
import 'package:frontend/widgets/bottomsticky.dart';
import 'package:frontend/api/chatcall.dart' as chatcall;

void main() {
  env.initApp(stage: env.stage);
  runApp(const ChatApp());
}

const userIdentity = "Leo";
final chatboxgkey = GlobalKey<chatbox.ChatBoxState>();
final homekey = GlobalKey<pagehome.PageHomeState>();

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  late int _currentIndex;
  late PageController _pageController;
  late List<Widget> bodyItems;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    bodyItems = [
      PageHome(key: homekey, chatboxgkey: chatboxgkey),
      const Center(
        child: Sticky(),
      ),
    ];

    _pageController = PageController(initialPage: _currentIndex);
  }

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
          body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: bodyItems),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                  label: 'Section A', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Section B', icon: Icon(Icons.settings)),
            ],
            onTap: (selectedIndex) => {
              setState(() {
                _currentIndex = selectedIndex;
                _pageController.jumpToPage(_currentIndex);
              })
            },
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
              final question = textcontroller.text;
              
              print(question);


              chatcall.ask(
                  state: state,
                  user_id: userIdentity,
                  question: question,
                  );
            },
          ),
        ));
  }
}
