import 'package:flutter/material.dart';

class Doroutine extends StatefulWidget {
  const Doroutine({super.key, required this.name, required this.description});

  static const String routeName = '/DoRoutine';

  final String name;
  final String description;

  @override
  State<Doroutine> createState() => _DoroutineState();
}

class _DoroutineState extends State<Doroutine> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name), // Use the widget's name property
      ),
      body: Container(
        child: Text('Do Routine: ${widget.name}\nDescription: ${widget.description}'), // Display the widget's name and description properties
      ),
    );
  }
}
