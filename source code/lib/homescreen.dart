import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rhythm_knight/checker.dart';
import 'package:rhythm_knight/gamescreen.dart';
import 'package:rhythm_knight/singleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final singleton = Singleton();
  StreamSubscription<DatabaseEvent>? listener;

  signOut() async {
    await auth.signOut().then((value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Checker())));
  }

  @override
  void initState() {
    super.initState();
    Singleton().addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listener == null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref(FirebaseAuth.instance.currentUser!.uid);
      listener = ref.onValue.listen((event) async {
        for (final child in event.snapshot.children) {
          if (child.key == "High Score") {
            singleton.score = child.value as int;
          }
        }
        if (mounted) setState(() {});
      });
    }

    int hScore = singleton.score;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Rhythm Knight",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "Highest Score: $hScore",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 44.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFF0069FE),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const GameScreen()));
                  },
                  child: const Text(
                    "Play",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFF0069FE),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    signOut();
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
