import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rhythm_knight/homescreen.dart';
import 'package:rhythm_knight/singleton.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double t = 387.5;
  double l = 150;
  int score = 0;
  late Timer T;
  int start = 10;
  bool game = false;
  final singleton = Singleton();

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    T = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            singleton.highScore(score);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    T.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: t - 300,
          left: l,
          child: Text(
            "Timer: $start",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: t - 200,
          left: l,
          child: Text(
            "Score: $score",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: t,
          left: l,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (!game) {
                  game = true;
                  startTimer();
                }
                score++;
              });
            },
            child: const Icon(
              Icons.audiotrack,
              color: Colors.blue,
              size: 100,
            ),
          ),
        ),
      ],
    ));
  }
}
