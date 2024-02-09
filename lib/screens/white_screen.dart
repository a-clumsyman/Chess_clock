// white_screen.dart
import 'dart:async';
import 'package:chess_clock/main.dart';
import 'package:flutter/material.dart';
import 'black_screen.dart';

class WhiteScreen extends StatefulWidget {
  final int initialTime;

  WhiteScreen({required this.initialTime});

  @override
  _WhiteScreenState createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  late Timer _timer;
  int _remainingTime = 0;
  bool _whitePaused = false;
  bool _blackPaused = true;
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
    player1RemainingTime = _whitePaused ? player1RemainingTime : _remainingTime;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _updateTimer();
        if (!_whitePaused && _remainingTime > 0) {
          _remainingTime--;
        } else if (_remainingTime == 0) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Time's up!"),
                content: Text("Black player wins!"),
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
    player1RemainingTime = _remainingTime;
    _pauseTimer();

    if (!_whitePaused) {
      _blackPaused = false;
      _blackTurns++;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlackScreen(
            initialTime: player2RemainingTime,
          ),
        ),
      );
    }
  }

  void _pausePlay() {
    setState(() {
      _whitePaused = !_whitePaused;
      if (_whitePaused) {
        _pauseTimer(); // Pause the timer
      } else {
        _startTimer(); // Resume the timer
      }
    });
  }

  void _stop() {
    _updateTimer();
    player1RemainingTime = _remainingTime;
    _pauseTimer();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _pauseTimer() {
    _updateTimer();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('White Turn'),
      ),
      body: GestureDetector(
        onTap: _switchTurns,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'White Timer: ${_remainingTime ~/ 60} min ${(_remainingTime % 60).toString().padLeft(2, '0')} sec',
                  style: TextStyle(
                    fontSize: 24,
                    color: _remainingTime <= 10 ? Colors.red : Colors.black,
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
                          Icon(_whitePaused ? Icons.play_arrow : Icons.pause),
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
