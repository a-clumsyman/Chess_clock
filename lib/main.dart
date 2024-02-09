// main.dart
import 'package:flutter/material.dart';
import 'package:chess_clock/screens/home_screen.dart';

int player1RemainingTime = 0;
int player2RemainingTime = 0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
