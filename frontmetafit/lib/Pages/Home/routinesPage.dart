import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ExerciseWidget.dart';
import 'package:frontmetafit/Components/RoutineWidget.dart';
import 'package:frontmetafit/const.dart';

class RoutinesPage extends StatefulWidget {
  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Column(
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 32),
                child: Text('Routines of the day',
                    style: TextStyles.headline1(context))),
            RoutineWidget(
              cantExercises: 2,
              percentage: '95%',
              equipment: 'Dumbells',
              name: 'Bench Press',
              difficulty: 'Medium',
              description: 'This is a description',
            ),
          ],
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, top: 40),
            child: Text('Other Routines',
                style: TextStyles.headline1(context),
                textAlign: TextAlign.left)),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: Column(
              spacing: 32,
              children: [
                for (int i = 0; i < 4; i++)
                  RoutineWidget(
                    description: 'This is a description',
                    difficulty: 'Medium',
                    equipment: 'Dumbells',
                    name: 'Bench Press',
                    percentage: '95%',
                    cantExercises: 2,
                  ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
