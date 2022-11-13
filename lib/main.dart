import 'dart:convert';
import 'dart:io';
import 'package:flora_dr/predict.dart';
import 'package:flora_dr/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import './get_from_camera.dart';
import './get_from_gallery.dart';

import 'go_back.dart';

void main() => runApp(const MyApp());

enum SingingCharacter {
  apple,
  corn,
  grape,
  tea,
  tomato,
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String plant = '';
  String health = '';
  String confidence = '';
  File? _image;
  bool showSpinner = false;
  var plantList = [
    'Apple',
    'Corn',
    'Grape',
    'Tea',
    'Tomato',
  ];
  SingingCharacter _character = SingingCharacter.apple;

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
    var uri = Uri.parse('http://10.0.2.2:5000/');
    var request = http.MultipartRequest('POST', uri);
    var multipart = http.MultipartFile(
      'image',
      stream,
      length,
      filename: _image!.path.split('/').last,
    );
    request.files.add(multipart);
    request.fields['plant'] = _character.name;

    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      final response = await http.get(uri);
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      setState(() {
        plant = decoded['plant'];
        health = decoded['health'];
        confidence = decoded['confidence'];
      });
    } else {
      setState(() {
        showSpinner = false;
      });
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
                                  plant = '';
                                  health = '';
                                  confidence = '';
                                })),
                            Predict(predict),
                          ],
                        ),
                        Result(showSpinner, plant, health, confidence),
                        //  Add button here
                      ],
                    )
                  : Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(8.0)),
                        Column(
                          children: [
                            const Center(
                              child: Text(
                                'Select a plant to check it\'s health !',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(15.0)),
                            RadioListTile(
                                title: Text(
                                  plantList[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: SingingCharacter.apple,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value!;
                                  });
                                }),
                            RadioListTile(
                                title: Text(
                                  plantList[1],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: SingingCharacter.corn,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value!;
                                  });
                                }),
                            RadioListTile(
                                title: Text(
                                  plantList[2],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: SingingCharacter.grape,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value!;
                                  });
                                }),
                            RadioListTile(
                                title: Text(
                                  plantList[3],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: SingingCharacter.tea,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value!;
                                  });
                                }),
                            RadioListTile(
                                title: Text(
                                  plantList[4],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: SingingCharacter.tomato,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value!;
                                  });
                                }),
                          ],
                        ),
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

// class RadioList extends StatefulWidget {
//   const RadioList({super.key});
//
//   @override
//   State<RadioList> createState() => _RadioListState();
// }
//
// class _RadioListState extends State<RadioList> {
//   var plantList = [
//     'Apple',
//     'Corn',
//     'Grape',
//     'Tea',
//     'Tomato',
//   ];
//   SingingCharacter _character = SingingCharacter.apple;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Center(
//           child: Text(
//             'Select a plant to check it\'s health !',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const Padding(padding: EdgeInsets.all(15.0)),
//         RadioListTile(
//             title: Text(
//               plantList[0],
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             value: SingingCharacter.apple,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value!;
//               });
//             }),
//         RadioListTile(
//             title: Text(
//               plantList[1],
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             value: SingingCharacter.corn,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value!;
//               });
//             }),
//         RadioListTile(
//             title: Text(
//               plantList[2],
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             value: SingingCharacter.grape,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value!;
//               });
//             }),
//         RadioListTile(
//             title: Text(
//               plantList[3],
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             value: SingingCharacter.tea,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value!;
//               });
//             }),
//         RadioListTile(
//             title: Text(
//               plantList[4],
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             value: SingingCharacter.tomato,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value!;
//               });
//             }),
//       ],
//     );
//   }
// }
