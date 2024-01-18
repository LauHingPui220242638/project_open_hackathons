import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';




void main() {
  runApp(MaterialApp(home: MyApp()));
}
/// App for testing
class MyApp extends StatefulWidget {
  /// Default Constructor
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FileUploadButton();
  }
}

class FileUploadButton extends StatefulWidget {
  @override
  _FileUploadButtonState createState() => _FileUploadButtonState();
}
class _FileUploadButtonState extends State<FileUploadButton> {
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text('UPLOAD FILE'),
          onPressed: () async {
            var picked = await FilePicker.platform.pickFiles(type: FileType.image);

            if (picked != null) {
              setState(() {
                _imageBytes = picked.files.first.bytes!;
              });
            }
          },
        ),
        if (_imageBytes != null)
          Image.memory(_imageBytes!),
      ],
    );
  }
}