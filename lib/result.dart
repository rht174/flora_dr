import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Result extends StatefulWidget {
  final String plant;
  final String health;
  final String confidence;
  final bool showSpinner;

  const Result(this.showSpinner, this.plant, this.health, this.confidence,
      {super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.showSpinner,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(20.0)),
          Text(
            'Plant: ${widget.plant}',
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          Text(
            'Condition: ${widget.health}',
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
          Text('Accuracy: ${widget.confidence}%',
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70)),
        ],
      ),
    );
  }
}
