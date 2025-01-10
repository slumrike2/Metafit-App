import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExerciseWidget.dart';
import 'package:frontmetafit/Components/VariationWidget.dart';
import 'package:frontmetafit/const.dart';

class Selectvariantexercise extends StatefulWidget {
  const Selectvariantexercise({super.key});
  static final routeName = '/selectVariant';

  @override
  State<Selectvariantexercise> createState() => _SelectvariantexerciseState();
}

class _SelectvariantexerciseState extends State<Selectvariantexercise> {
  Map<String, dynamic>? selectedExercise;

  void selectExercise(Map<String, dynamic> exercise) {
    setState(() {
      selectedExercise = exercise;
      print(selectedExercise);
    });
  }

 
  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final exercises =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final filteredExercises =
        exercises.where((exercise) => exercise['option'] != 1).toList();

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Stack(children: [
            Column(
              spacing: 16,
              children: [
                Text('Variants', style: TextStyles.headline1(context)),
                for (var exercise in filteredExercises)
                  VariationWidget(
                    exercise: exercise,
                    selected: selectedExercise == exercise,
                    onPressed: () => selectExercise(exercise),
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
                      text: 'Change',
                      onPressed: () {
                        if (selectedExercise != null) {
                          final selectedExerciseIndex =
                              exercises.indexOf(selectedExercise);

                          // Set the selected exercise option to 1
                          exercises[selectedExerciseIndex]['option'] = 1;

                          // Update all other options
                          int optionCounter = 2;
                          for (var i = 0; i < exercises.length; i++) {
                            if (i != selectedExerciseIndex) {
                              exercises[i]['option'] = optionCounter;
                              optionCounter++;
                            }
                          }

                          Navigator.pop(context, exercises);
                        }
                      })),
            )
          ]),
        ));
  }
}
