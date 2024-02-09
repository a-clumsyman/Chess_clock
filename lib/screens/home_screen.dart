// home_screen.dart
import 'package:flutter/material.dart';
import 'package:chess_clock/timer_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerButton(minutes: 1),
            SizedBox(height: 20),
            TimerButton(minutes: 3),
            SizedBox(height: 20),
            TimerButton(minutes: 5),
            SizedBox(height: 20),
            TimerButton(minutes: 10),
            SizedBox(height: 20),
            TimerButton(minutes: 15),
          ],
        ),
      ),
    );
  }
}
