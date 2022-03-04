import 'package:flutter/material.dart';
import 'package:my_timerapp/timer_body.dart';

void main() {
  runApp(ActiveTimerApp());
}

class ActiveTimerApp extends StatelessWidget {
  const ActiveTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ActiveTimer(),
    );
  }
}

class ActiveTimer extends StatelessWidget {
  const ActiveTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF73d6ff),
      appBar: AppBar(
        title: Text("Active Timer"),
        centerTitle: true,
        backgroundColor: Color(0xFF1c7589),
      ),
      body: Body(),
    );
  }
}

