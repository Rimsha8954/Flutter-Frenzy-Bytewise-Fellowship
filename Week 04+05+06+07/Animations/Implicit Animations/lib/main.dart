import 'package:flutter/material.dart';
import 'implicit_animation.dart';

void main() {
  runApp(const MyApp());
}

/// Animation is an abstract class that interpolates number between two values over a certain duration
/// One of the commonly used type is Animation<double>
/// while an animationController is used to manage the animations , controlling animations to start or stop
/// By default animation Controller linearly produces the number from 0.0 to 0.1 during a given duration


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImplicitAnimation(),
    );
  }
}
