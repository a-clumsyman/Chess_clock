import 'package:flutter/material.dart';
import 'package:chess_clock/screens/white_screen.dart';

class TimerButton extends StatelessWidget {
  final int minutes;

  TimerButton({required this.minutes});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WhiteScreen(minutes: minutes)),
        );
      },
      child: Text('$minutes min'),
    );
  }
}
