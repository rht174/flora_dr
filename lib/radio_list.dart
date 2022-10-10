import 'package:flutter/material.dart';

class RadioList extends StatelessWidget {
  const RadioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        RadioListTile(
            title: Text('Plant 1'),
            value: null,
            groupValue: null,
            onChanged: null),
      ],
    );
  }
}
