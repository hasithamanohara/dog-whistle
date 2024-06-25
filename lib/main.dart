import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'splash_screen.dart';

void main() {
  runApp(DogWhistleApp());
}

class DogWhistleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Whistle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
