import 'package:flutter/material.dart';

class PreStartText extends StatelessWidget {
  static String name = 'preStartText';

  const PreStartText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Text(
          'After a few moments, start the game.',
          style: TextStyle(
            fontFamily: 'ONEMobilePOP',
            color: Colors.white,
            decoration: TextDecoration.none,
            fontSize: 32,
            shadows: [
              Shadow(
                  // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: Colors.black),
              Shadow(
                  // bottomRightR
                  offset: Offset(1.5, -1.5),
                  color: Colors.black),
              Shadow(
                  // topRight
                  offset: Offset(1.5, 1.5),
                  color: Colors.black),
              Shadow(
                  // topLeft
                  offset: Offset(-1.5, 1.5),
                  color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
