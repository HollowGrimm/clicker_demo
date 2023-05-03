import 'package:flutter/material.dart';

class Singleton extends ChangeNotifier {
  static final Singleton _instance = Singleton._internal();

  // passes the instantiation to the _instance object
  factory Singleton() => _instance;

  // initialize our variables
  Singleton._internal();

  int score = 0;

  void highScore(int newScore) {
    if (newScore > score) {
      score = newScore;
    }
    notifyListeners();
  }
}
