import 'package:flutter/material.dart';

enum SingingCharacter {
  b1,
  b2,
  b3,
  b4,
  b5,
  b6,
  b7,
  b8,
  b9,
}

class RadioList extends StatefulWidget {
  const RadioList({super.key});

  // final String title;
  // final SingingCharacter x;
  // const RadioList(this.title, this.x, {super.key});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  var plantList = [
    'Apple',
    'Cherry',
    'Corn',
    'Grape',
    'Pepper Bell',
    'Potato',
    'Strawberry',
    'Tea',
    'Tomato',
  ];
  SingingCharacter _character = SingingCharacter.b1;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Padding(padding: EdgeInsets.all(2.0)),
        RadioListTile(
            title: Text(
              plantList[0],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b1,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[1],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b2,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[2],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b3,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[3],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b4,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[4],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b5,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[5],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b6,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[6],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b7,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[7],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b8,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value!;
              });
            }),
        RadioListTile(
            title: Text(
              plantList[8],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: SingingCharacter.b9,
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
