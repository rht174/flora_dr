import 'package:flutter/material.dart';

class Predict extends StatelessWidget {
  final VoidCallback pressPredict;

  const Predict(this.pressPredict, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: pressPredict,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan[800],
        ),
        child: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Text(
              'Predict ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.forward),
          ],
        ),
      ),
    );
  }
}
