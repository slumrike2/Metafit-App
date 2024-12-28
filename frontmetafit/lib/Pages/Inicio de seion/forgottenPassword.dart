import 'package:flutter/material.dart';

class forgottenPassword extends StatefulWidget {
  static const String routeName = '/forgottenPassword';
  const forgottenPassword({Key? key}) : super(key: key);

  @override
  State<forgottenPassword> createState() => _forgottenPasswordState();
}

class _forgottenPasswordState extends State<forgottenPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'))),
    );
  }
}
