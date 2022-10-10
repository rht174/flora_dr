import 'package:flutter/material.dart';

enum SingingCharacter {
  b1,
  b2,
  b3,
  b4,
  b5,
}

class RadioList extends StatefulWidget {
  const RadioList({Key? key}) : super(key: key);

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  SingingCharacter _character = SingingCharacter.b1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile(
            title: const Text('Plant 1'),
            value: SingingCharacter.b1,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: const Text('Plant 2'),
            value: SingingCharacter.b2,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: const Text('Plant 3'),
            value: SingingCharacter.b3,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: const Text('Plant 4'),
            value: SingingCharacter.b4,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: const Text('Plant 5'),
            value: SingingCharacter.b5,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
      ],
    );
  }
}
