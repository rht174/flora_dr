import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './get_from_camera.dart';
import './get_from_gallery.dart';
import './radio_list.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('floraDr'),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/app_bg.jpg',
              ),
              fit: BoxFit.cover,
              opacity: 950.0,
            ),
          ),
          child: Column(
            children: <Widget>[
              _image != null
                  ? Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(25.0)),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.all(Radius.zero),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Image.file(
                            _image!,
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      //  Add button here
                      ],
                    )
                  : Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(8.0)),
                        const RadioList(),
                        const Padding(padding: EdgeInsets.all(20.0)),
                        Galley(() => pickImage(ImageSource.gallery)),
                        Camera(() => pickImage(ImageSource.camera)),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
