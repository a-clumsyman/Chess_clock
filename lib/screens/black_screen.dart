// black_screen.dart
import 'dart:async';
import 'package:chess_clock/main.dart';
import 'package:flutter/material.dart';
import 'package:chess_clock/screens/white_screen.dart';

class BlackScreen extends StatefulWidget {
  final int initialTime;

  BlackScreen({required this.initialTime});

  @override
  _BlackScreenState createState() => _BlackScreenState();
}

class _BlackScreenState extends State<BlackScreen> {
  late Timer _timer;
  int _remainingTime = 0;
  bool _whitePaused = true;
  bool _blackPaused = false;
  int _whiteTurns = 0;
  int _blackTurns = 0;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialTime;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimer() {
    player2RemainingTime = _blackPaused ? player2RemainingTime : _remainingTime;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _updateTimer();
        if (!_blackPaused && _remainingTime > 0) {
          _remainingTime--;
        } else if (_remainingTime == 0) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Time's up!"),
                content: Text("White player wins!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          _timer.cancel();
        }
      });
    });
  }

  void _switchTurns() {
    _updateTimer();
    player2RemainingTime = _remainingTime;
    _pauseTimer();

    if (!_blackPaused) {
      _whitePaused = false;
      _whiteTurns++;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WhiteScreen(
            initialTime: player1RemainingTime,
          ),
        ),
      );
    }
  }

  void _pausePlay() {
    setState(() {
      _blackPaused = !_blackPaused;
      if (_blackPaused) {
        _pauseTimer(); // Pause the timer
      } else {
        _startTimer(); // Resume the timer
      }
    });
  }

  void _stop() {
    _updateTimer();
    player2RemainingTime = _remainingTime;
    _pauseTimer();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _pauseTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Black Turn'),
      ),
      body: GestureDetector(
        onTap: _switchTurns,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Black Timer: ${_remainingTime ~/ 60} min ${(_remainingTime % 60).toString().padLeft(2, '0')} sec',
                  style: TextStyle(
                    fontSize: 24,
                    color: _remainingTime <= 10 ? Colors.red : Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _pausePlay();
                      },
                      child:
                          Icon(_blackPaused ? Icons.play_arrow : Icons.pause),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () {
                        _stop();
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
