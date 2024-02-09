// timer_button.dart
import 'package:flutter/material.dart';
import 'package:chess_clock/screens/white_screen.dart';
import 'package:chess_clock/main.dart';

class TimerButton extends StatelessWidget {
  final int minutes;

  TimerButton({required this.minutes});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        player1RemainingTime = minutes * 60;
        player2RemainingTime = minutes * 60;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WhiteScreen(initialTime: minutes * 60)),
        );
      },
      child: Text('$minutes min'),
    );
  }
}
