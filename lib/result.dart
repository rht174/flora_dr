import 'package:flora_dr/go_back.dart';
import 'package:flora_dr/predict.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Result extends StatefulWidget {
  final bool showSpinner;
  const Result(this.showSpinner, {super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.showSpinner,
      child: Column(
        children: const [
          Padding(padding: EdgeInsets.all(10.0)),
          Text('param 1'),
          Text('param 2'),
          Text('param 3'),
        ],
      ),
    );
  }
}
