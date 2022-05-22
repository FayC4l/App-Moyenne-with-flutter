import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Ajouter un Module...',
              speed: const Duration(milliseconds: 150),
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          displayFullTextOnTap: true,
          stopPauseOnTap: false,
        ),
      ),
    );
  }
}
