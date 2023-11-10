import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';



final player = AudioPlayer();

final record = AudioRecorder();

Future<void> startRecord() async {
  // Check and request permission if needed
  if (await record.hasPermission()) {
    // Start recording to file
    await record.start(const RecordConfig(encoder: AudioEncoder.wav),
        path: 'aFullPath/myFile.wav');
    // ... or to stream
    // final stream = await record
    //     .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
  }
}

Future<void> stopRecord() async {
  // Stop recording...
  final path = await record.stop();
  print(path);
  await player.play(UrlSource(path!));

  // ... or cancel it (and implicitly remove file/blob).
  await record.dispose();

}
