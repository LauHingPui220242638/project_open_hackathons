import 'package:flutter/material.dart';
import 'package:frontend/env.dart' as env;

import 'package:frontend/pages/pagehome.dart';
import 'package:frontend/pages/pagehome.dart' as pagehome;
import 'package:frontend/widgets/buttonsubmit.dart';
import 'package:frontend/widgets/chatbox.dart' as chatbox;
import 'package:frontend/widgets/bottomsticky.dart';

void main() {
  env.initApp(stage: env.stage);
  runApp(const ChatApp());
}

const user_id = "Leo";
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
        title: 'EventChat',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 7, 41),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Hi! $user_id\'s, Welcome to EventChat',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceTint,
          ),
          body: PageView(
              controller: _pageController,
              physics: const AlwaysScrollableScrollPhysics(),
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
          floatingActionButton: SubmitButton(),
        ));
  }
}
