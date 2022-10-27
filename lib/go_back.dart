import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  final VoidCallback goBack;

  const GoBack(this.goBack, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: goBack,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan[800],
        ),
        child: Row(
          children: const [
            Icon(Icons.arrow_back_sharp),
            SizedBox(
              width: 10,
            ),
            Text(
              'Go Back',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
