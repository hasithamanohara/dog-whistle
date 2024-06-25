import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const DogWhistleApp());
}

class DogWhistleApp extends StatelessWidget {
  const DogWhistleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog Whistle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
