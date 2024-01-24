import 'package:flutter/material.dart';

class SecondTimeView extends StatefulWidget {
  SecondTimeView({
    super.key,
  });

  @override
  State<SecondTimeView> createState() => _SecondTimeViewState();
}

class _SecondTimeViewState extends State<SecondTimeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
