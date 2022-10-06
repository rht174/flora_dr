import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  final VoidCallback selectCamera;
  const Camera(this.selectCamera, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: selectCamera,
        child: Row(
          children: const [
            Icon(Icons.camera_alt),
            SizedBox(
              width: 20,
            ),
            Text(
              'Click an Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
