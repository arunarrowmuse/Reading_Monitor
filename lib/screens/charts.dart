import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("charts"),
      ),
    );
  }
}
