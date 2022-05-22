import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ResultatPage extends StatefulWidget {
  final double Moyenne;

  const ResultatPage({Key? key, required this.Moyenne}) : super(key: key);

  @override
  State<ResultatPage> createState() => _ResultatPageState();
}

class _ResultatPageState extends State<ResultatPage> {
  bool isPlaying = false;
  final controller = ConfettiController();
  String img = "assets/moin.png";

  @override
  void initState() {
    super.initState();
    if (widget.Moyenne >= 10) {
      controller.play();
      img = "assets/plus.png";
    } else {
      img = "assets/moin.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              "Résultat",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Votre moyenne est :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Text(
                          "${widget.Moyenne.toStringAsFixed(2)}  ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 45),
                        ),
                      ],
                    ),
                  ),
                ),
                Image(image: AssetImage(img)),
              ],
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          gravity: 0.2,
          emissionFrequency: 0.01,
          numberOfParticles: 20,
        ),
      ],
    );
  }
}
