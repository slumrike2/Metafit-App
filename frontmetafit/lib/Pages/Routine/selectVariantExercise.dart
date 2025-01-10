import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExerciseWidget.dart';
import 'package:frontmetafit/const.dart';

class Selectvariantexercise extends StatefulWidget {
  const Selectvariantexercise({super.key});
  static final routeName = '/selectVariant';

  @override
  State<Selectvariantexercise> createState() => _SelectvariantexerciseState();
}

class _SelectvariantexerciseState extends State<Selectvariantexercise> {
  String selectedExercise = '';

  void selectExercise(String name) {
    setState(() {
      selectedExercise = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Stack(children: [
            Column(
              spacing: 16,
              children: [
                Text('Variants', style: TextStyles.headline1(context)),
                Exercisewidget(
                  sets: 12,
                  equipment: 'none',
                  name: 'Exercise 1',
                  difficulty: 'hard',
                  description: 'Description for Exercise 1',
                  showSelectButton: true,
                  isSelected: selectedExercise == 'Exercise 1',
                  getName: () {
                    selectExercise('Exercise 1');
                    print('Exercisewidget name: Exercise 1');
                    return;
                  },
                ),
                Exercisewidget(
                  sets: 10,
                  equipment: 'dumbbells',
                  name: 'Exercise 2',
                  difficulty: 'medium',
                  description: 'Description for Exercise 2',
                  showSelectButton: true,
                  isSelected: selectedExercise == 'Exercise 2',
                  getName: () {
                    selectExercise('Exercise 2');
                    print('Exercisewidget name: Exercise 2');
                  },
                ),
                Exercisewidget(
                  sets: 8,
                  equipment: 'barbell',
                  name: 'Exercise 3',
                  difficulty: 'easy',
                  description: 'Description for Exercise 3',
                  showSelectButton: true,
                  isSelected: selectedExercise == 'Exercise 3',
                  getName: () {
                    selectExercise('Exercise 3');
                    print('Exercisewidget name: Exercise 3');
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizew * 0.25),
                  child: ConfirmButton(
                      text: 'Changue',
                      onPressed: () => Navigator.pop(context))),
            )
          ]),
        ));
  }
}
