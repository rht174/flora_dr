import 'dart:io';
import 'package:flora_dr/predict.dart';
import 'package:flora_dr/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import './get_from_camera.dart';
import './get_from_gallery.dart';
import './radio_list.dart';
import 'go_back.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _image;
  bool showSpinner = false;

  Future pickImage(ImageSource source) async {
    final imagePicked = await ImagePicker().pickImage(source: source);
    if (imagePicked == null) return;
    final imageTemp = File(imagePicked.path);
    setState(() {
      _image = imageTemp;
    });
  }

  Future predict() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(_image!.openRead());
    stream.cast();
    var length = await _image!.length();
    var uri = Uri.parse('http://10.0.2.2:5000/predict');
    var request = http.MultipartRequest('POST', uri);
    var multipart = http.MultipartFile(
      'image',
      stream,
      length,
    );
    request.files.add(multipart);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('done');
    } else {
      setState(() {
        showSpinner = false;
      });
      print('not done');
    }
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
                        const Padding(padding: EdgeInsets.all(10.0)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GoBack(() => setState(() {
                                  _image = null;
                                })),
                            Predict(predict),
                          ],
                        ),
                        Result(showSpinner), //  Add button here
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
