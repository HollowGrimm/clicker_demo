import 'package:flutter/material.dart';
import 'package:rhythm_knight/checker.dart';

void main() {
  runApp(const RhythmKnight());
}

class RhythmKnight extends StatelessWidget {
  const RhythmKnight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Checker());
  }
}
