import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './get_from_camera.dart';
import './get_from_gallery.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _image;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      _image = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('floraDr'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 500,
                      width: 500,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(
                      height: 300,
                    ),
              const SizedBox(
                height: 40,
              ),
              Galley(() => pickImage(ImageSource.gallery)),
              Camera(() => pickImage(ImageSource.camera)),
            ],
          ),
        ),
      ),
    );
  }
}
