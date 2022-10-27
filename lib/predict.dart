import 'package:flutter/material.dart';
class Predict extends StatelessWidget {
  const Predict({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () => null,
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
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.forward),
          ],
        ),
      ),
    );
  }
}
