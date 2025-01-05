import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExcersiceExpanded.dart';
import 'package:frontmetafit/Components/VariationWidget.dart';

class ProgressPage extends StatefulWidget {
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Excersiceexpanded(
            name: 'Exercise Name de no se que vergas ns',
            description: 'Exercise Description',
            difficulty: 'Exercise Difficulty',
            equipment: 'Exercise Equipment',
            muscles: 'Exercise Muscles',
            series: 3,
            reps: 12,
          ),
          ConfirmButton(text: "Start", onPressed: () {}),
        ],
      ),
    );
  }
}
