import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text("hola madre mia querida",
        textDirection: TextDirection.ltr);
  }
}
