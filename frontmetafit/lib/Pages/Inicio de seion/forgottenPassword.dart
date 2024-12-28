import 'package:flutter/material.dart';

class forgottenPassword extends StatefulWidget {
  static const String routeName = '/forgottenPassword';
  const forgottenPassword({super.key});

  @override
  State<forgottenPassword> createState() => _forgottenPasswordState();
}

// ignore: camel_case_types
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
