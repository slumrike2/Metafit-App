import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExerciseWidget.dart';
import 'package:frontmetafit/Pages/Routine/doRoutine.dart';
import 'package:frontmetafit/const.dart';

class Routinepreview extends StatelessWidget {
  const Routinepreview({super.key});

  static const String routeName = '/RoutinePreview';

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Exercises', style: TextStyles.headline0(context)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.secondary,
                  width: 2,
                ),
              ),
              child: Text(
                '45 minutes',
                style: TextStyles.bodyBebas(context),
              ),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Exercisewidget(
                        name: 'Exercise $index',
                        description: 'Description of exercise $index',
                        equipment: 'Equipment',
                        reps: 10,
                        sets: index,
                        difficulty: 'Easy',
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizew * 0.25),
            child: ConfirmButton(
                text: 'Start',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Doroutine.routeName,
                    arguments: {
                      'name': 'Routine Name', // Pass the name as an argument
                      'description': 'Routine Description' // Pass the description as an argument
                    },
                  );
                }),
          ),
        )
      ]),
    );
  }
}
