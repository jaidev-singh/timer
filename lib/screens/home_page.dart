import 'package:flutter/material.dart';
import 'dart:async';
import '../widget/button_widget.dart';
import '../widget/gradient_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

//
  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'Pause' : 'Resume',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                  } else {
                    startTimer(reset: false);
                  }
                },
              ),
              SizedBox(width: 12),
              ButtonWidget(
                text: 'Cancel',
                onClicked: stopTimer,
              ),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            onClicked: () {
              startTimer();
            },
            color: Colors.white,
            backgroundColor: Colors.black,
          );
  }

  Widget buildTime() {
    if (seconds == 0) {
      return Icon(
        Icons.done,
        color: Colors.greenAccent,
        size: 112,
      );
    } else {
      return Text(
        '$seconds',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 80,
        ),
      );
    }
  }

  Widget buildTimer() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            // 1- , changes the direction of progressbar to clockwise
            value: 1 - seconds / maxSeconds,
            strokeWidth: 12,
            valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent),
            backgroundColor: Colors.greenAccent,
          ),
          Center(
            child: buildTime(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GradientWidget(
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimer(),
                SizedBox(height: 80),
                buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
