import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/env.dart';

class DImage extends StatefulWidget {
  final FilePickerResult? image;
  const DImage( {Key? key, required this.image}): super(key: key);

  @override
  State<DImage> createState() => DImageState();
}

class DImageState extends State<DImage> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:10),
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          
          child: ClipRRect(
            
            borderRadius:  const BorderRadius.all(Radius.circular(ROUNDED_CORNER_GLOBAL)),
            child: Image.memory(
              widget.image!.files.first.bytes!,
              fit: BoxFit.cover,
            ),
            ),
          )
        );
  }
}
