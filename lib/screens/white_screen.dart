import 'package:flutter/material.dart';
import 'black_screen.dart';

class WhiteScreen extends StatefulWidget {
  final int minutes;

  WhiteScreen({required this.minutes});

  @override
  _WhiteScreenState createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  int whiteTime = 0;
  int blackTime = 0;
  bool whitePaused = false;
  bool blackPaused = true;
  int whiteTurns = 0;
  int blackTurns = 0;

  void switchTurns() {
    if (!whitePaused) {
      whitePaused = true;
      blackPaused = false;
      blackTurns++;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlackScreen(minutes: widget.minutes)),
      );
    }
  }

  void pausePlay() {
    setState(() {
      whitePaused = !whitePaused;
    });
  }

  void stop() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('White Turn'),
      ),
      body: GestureDetector(
        onTap: switchTurns,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'White Timer: ${widget.minutes} minutes',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        pausePlay();
                      },
                      child: Icon(whitePaused ? Icons.play_arrow : Icons.pause),
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
