import 'package:flutter/material.dart';
import 'package:chess_clock/screens/white_screen.dart';

class BlackScreen extends StatefulWidget {
  final int minutes;

  BlackScreen({required this.minutes});

  @override
  _BlackScreenState createState() => _BlackScreenState();
}

class _BlackScreenState extends State<BlackScreen> {
  int whiteTime = 0;
  int blackTime = 0;
  bool whitePaused = true;
  bool blackPaused = false;
  int whiteTurns = 0;
  int blackTurns = 0;

  void switchTurns() {
    if (!blackPaused) {
      blackPaused = true;
      whitePaused = false;
      whiteTurns++;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WhiteScreen(minutes: widget.minutes)),
      );
    }
  }

  void pausePlay() {
    setState(() {
      blackPaused = !blackPaused;
    });
  }

  void stop() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Black Turn'),
      ),
      body: GestureDetector(
        onTap: switchTurns,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Black Timer: ${widget.minutes} minutes',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        pausePlay();
                      },
                      child: Icon(blackPaused ? Icons.play_arrow : Icons.pause),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () {
                        stop();
                      },
                      child: Icon(Icons.stop),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
