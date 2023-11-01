import 'package:flutter/material.dart';

class Sticky extends StatefulWidget {
  const Sticky({Key? key}) : super(key: key);

  @override
  _StickyState createState() => _StickyState();
}


class _StickyState extends State<Sticky> {
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