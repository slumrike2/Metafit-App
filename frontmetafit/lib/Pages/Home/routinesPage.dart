import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ExerciseWidget.dart';

class RoutinesPage extends StatefulWidget {
  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Exercisewidget(
            reps: 12,
            sets: 3,
            equipment: 'Dumbells',
            name: 'Bench Press',
            difficulty: 'Medium',
            description: 'This is a description'),
      ),
    );
  }
}
