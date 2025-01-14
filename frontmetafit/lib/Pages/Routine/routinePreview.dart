import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExerciseWidget.dart';
import 'package:frontmetafit/Pages/Routine/doRoutine.dart';
import 'package:frontmetafit/Pages/Routine/selectVariantExercise.dart';
import 'package:frontmetafit/const.dart';

class Routinepreview extends StatefulWidget {
  const Routinepreview({super.key, required this.workoutData});

  static const String routeName = '/RoutinePreview';
  final Map<String, dynamic> workoutData;

  @override
  _RoutinepreviewState createState() => _RoutinepreviewState();
}

class _RoutinepreviewState extends State<Routinepreview> {
// Temporary list to store used indices

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;
    final exercises = widget.workoutData['workout_exercises'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises', style: TextStyles.headline0(context)),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: CantExercises(exercises),
                  itemBuilder: (context, index) {
                    final sequenceExercises = exercises
                        .where((seqExercise) =>
                            seqExercise['sequence'] == index + 1)
                        .toList();

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Exercisewidget(
                        exercise: sequenceExercises,
                        onButtonPressed: () async {
                          final updatedExercises = await Navigator.pushNamed(
                            context,
                            Selectvariantexercise.routeName,
                            arguments: sequenceExercises,
                          ) as List<dynamic>?;

                          if (updatedExercises != null) {
                            setState(() {
                              List<int> usedIndices = [];

                              for (var updatedExercise in updatedExercises) {
                                final sequence = updatedExercise['sequence'];
                                final index = exercises.indexWhere((exercise) =>
                                    exercise['sequence'] == sequence &&
                                    !usedIndices
                                        .contains(exercises.indexOf(exercise)));

                                if (index != -1 &&
                                    !usedIndices.contains(index)) {
                                  exercises[index] = updatedExercise;
                                  usedIndices.add(index); // Mark as used
                                }
                              }
                              // Ensure the exercises list is sorted by sequence to avoid duplicates
                              exercises.sort((a, b) =>
                                  a['sequence'].compareTo(b['sequence']));
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
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
                    arguments: widget.workoutData,
                  );
                }),
          ),
        )
      ]),
    );
  }

  CantExercises(exercises) {
    return exercises.where((exercise) => exercise['option'] == 1).length;
  }
}
