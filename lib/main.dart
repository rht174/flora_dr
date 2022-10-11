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
          actions: [
            IconButton(
              onPressed: () {
                final snackbar = SnackBar(
                  content: const Text('this is info'),
                  action: SnackBarAction(
                    label: 'ok',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
              icon: const Icon(
                Icons.info_outline,
              ),
              tooltip: 'show info',
              iconSize: 28,
            )
          ],
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/app_bg.jpg',
              ),
              fit: BoxFit.cover,
              opacity: 80.0,
            ),
          ),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              const Center(
                child: Text(
                  'Select a plant to check it\'s health !',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(3.0)),
              const RadioList(),
              const Padding(padding: EdgeInsets.all(7.0)),
              // _image != null
                  // ? Image.file(
                  //     _image!,
                  //     height: 500,
                  //     width: 500,
                  //     fit: BoxFit.cover,
                  //   )
                  // :
              Galley(() => pickImage(ImageSource.gallery)),
              Camera(() => pickImage(ImageSource.camera)),
            ],
          ),
        ),
      ),
    );
  }
}
