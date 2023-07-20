import 'dart:async';
import 'package:flutter/material.dart';
import 'signinscreen.dart';

class splashscreen extends StatefulWidget {
  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  FutureOr<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => signinscreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: SweepGradient(
                colors: [
                  Colors.yellow.shade700,
                  Colors.yellow.shade500,
                  Colors.yellow.shade700,
                  Colors.yellow.shade500,
                  Colors.yellow.shade700
                ],
                stops: [0.0, 0.25, 0.5, 0.75, 1],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/ALogo.png',
                    height: 250,
                    width: 300,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ResQ",
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )));
  }
}
