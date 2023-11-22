import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/pagehome.dart';
import 'package:frontend/widgets/chatbox.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:frontend/api/chatcall.dart' as chatcall;
import 'package:flutter_tts/flutter_tts.dart';

class SubmitButton extends StatefulWidget {
  final double buttonHeight;
  final double buttonWidth;
  const SubmitButton({
    Key? key,
    required this.buttonHeight,
    required this.buttonWidth,
  }) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  late PageHomeState homestate = homekey.currentState!;
  late final textcontroller = homestate.textcontroller;
  late ChatBoxState chatboxState = chatboxgkey.currentState!;
  late final scrollController = chatboxState.scrollController;
  late SpeechToText _speechToText = SpeechToText();
  late FlutterTts flutterTts;
  bool _speechEnabled = false;

  void initState() {
    super.initState();
    initSpeech();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();
  }
  
  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
  
  
  void _speak(chat) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    print(chat);
    if (chat != null) {
      if (chat!.isNotEmpty) {
        print(chat);
        await flutterTts.speak(chat);
      }
    }
    else{
      throw Exception('Chat is Null');
    }
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

  Future<String> textSubmit() async {

    final chat = await chatcall.ask(
      state: chatboxState,
      user_id: user_id,
      chat: textcontroller.text,
    );
    textcontroller.clear();
    print("adding chat : " + chat);
    return chat;
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print(_speechEnabled);
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
  Future stopListening() async {
    await _speechToText.stop();
    setState(() {
      _speechEnabled = false;
      _button = buttonLUP;
    });
    final String chat = await textSubmit();
    _speak(chat);
    
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    if (_speechEnabled == true) {
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
      child: Container(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: textSubmit,
            child: _button,
          ),
        ),
      ),
    );
  }
}
