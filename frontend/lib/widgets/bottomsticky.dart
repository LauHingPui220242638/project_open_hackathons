import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                color: Colors.black38,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: const Text('Header'),
              ),
            ),
            Positioned(
              top: 60,
              child: Container(
                child: const Text('Content'),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: const Text('Footer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
