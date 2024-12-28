import 'package:flutter/material.dart';

class RoutinesPage extends StatefulWidget {
  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routines'),
      ),
      body: Center(
        child: Text('Routines Page'),
      ),
    );
  }
}
