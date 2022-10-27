import 'package:flora_dr/go_back.dart';
import 'package:flora_dr/predict.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(padding: EdgeInsets.all(10.0)),
        Text('param 1'),
        Text('param 2'),
        Text('param 3'),
      ],
    );
  }
}
