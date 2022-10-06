import 'package:flutter/material.dart';

class Galley extends StatelessWidget {
  final VoidCallback selectGallery;
  const Galley(this.selectGallery, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: selectGallery,
        child: Row(
          children: const [
            Icon(Icons.image),
            SizedBox(
              width: 20,
            ),
            Text(
              'Choose from Gallery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
