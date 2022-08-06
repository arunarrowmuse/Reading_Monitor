import 'package:flutter/material.dart';

class SwitchUser extends StatefulWidget {
  const SwitchUser({Key? key}) : super(key: key);

  @override
  State<SwitchUser> createState() => _SwitchUserState();
}

class _SwitchUserState extends State<SwitchUser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Switch User"),
      ),
    );
  }
}