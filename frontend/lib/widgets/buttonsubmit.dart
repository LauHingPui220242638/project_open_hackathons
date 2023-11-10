import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/pagehome.dart';
import 'package:frontend/widgets/chatbox.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:frontend/api/chatcall.dart' as chatcall;

class SubmitButton extends StatefulWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  late PageHomeState homestate = homekey.currentState!;
  late final textcontroller = homestate.textcontroller;
  late ChatBoxState state = chatboxgkey.currentState!;
  late final controller = state.controller;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  
  void initState() {
    super.initState();
    initSpeech();

    
  }

  
  final Icon buttonLPR = const Icon(
    Icons.record_voice_over,
    color: Colors.pink,
    size: 24.0,
    semanticLabel: 'Ask',
  );

  final Icon buttonLUP = const Icon(
    Icons.arrow_forward_ios,
    color: Colors.pink,
    size: 24.0,
    semanticLabel: 'Ask',
  );

  late Icon _button = buttonLUP;

  void Function()? textSubmit() {
    print("adding item");
    

    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    
   

    chatcall.ask(
      state: state,
      user_id: user_id,
      chat: textcontroller.text,
    );
    textcontroller.clear();
    return null;
  }
  
  
  
  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
  
  void startListening() async {
    
    await _speechToText.listen(onResult: onSpeechResult);
    setState(() {
      _speechEnabled = true;
      _button = buttonLPR;
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await _speechToText.stop();
    setState(() {
      _speechEnabled = false;
      _button = buttonLUP;
    });
    textSubmit();
  }  
  void onSpeechResult(SpeechRecognitionResult result) {
    if (_speechEnabled == true){
      setState(() {
        textcontroller.text = result.recognizedWords;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print("Long Pressed!!");
        startListening();
      },
      onLongPressUp: () {
        print("Long Pressed Up!!");
        stopListening();
      },
      child: FloatingActionButton(
        onPressed: textSubmit,
        child: _button,
      ),
    );
  }
}
