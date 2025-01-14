import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Components/ExcersiceExpanded.dart';
import 'package:frontmetafit/Pages/Routine/Review.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Doroutine extends StatefulWidget {
  const Doroutine({super.key, required this.workoutData});

  static const String routeName = '/DoRoutine';

  final workoutData;

  @override
  State<Doroutine> createState() => _DoroutineState();
}

class _DoroutineState extends State<Doroutine> {
  SupabaseClient supabase = Supabase.instance.client;
  String selectedExercise = '';
  int currentPage = 0;
  int remainingTime = 0;
  Timer? _timer;
  final PageController _pageController = PageController();
  bool isPaused = true;

  void selectExercise(String name) {
    setState(() {
      selectedExercise = name;
    });
  }

  void startTimer() {
    setState(() {
      isPaused = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          isPaused = true;
          // Add logic to handle end of timer if needed
        }
      });
    });
  }

  void nextPage(int aux) async {
    if (currentPage < aux) {
      // Adjust the condition based on the number of pages
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      return;
    }
    await supabase.from('workouts').update({
      'done': true,
    }).eq('id', widget.workoutData['id']);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    final workoutExercises = args?['workout_exercises'] as List<dynamic>? ?? [];
    final realExercises = workoutExercises
        .where((exercise) =>
            exercise['exercises'] != null && exercise['option'] == 1)
        .toList();

    return Scaffold(
      appBar: AppBar(
        // Use the widget's name property
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Time: ${remainingTime}s'),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // Disable swiping
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: [
              for (var i = 0; i < realExercises.length; i++) ...[
                Excersiceexpanded(
                  name: realExercises[i]['exercises']['name'],
                  description: realExercises[i]['exercises']['description'],
                  difficulty: realExercises[i]['exercises']['difficulty'],
                  equipment: (realExercises[i]['exercises']
                                  ['exercise_equipment'] !=
                              null &&
                          realExercises[i]['exercises']['exercise_equipment']
                              .isNotEmpty)
                      ? realExercises[i]['exercises']['exercise_equipment'][0]
                          ['equipment']['name']
                      : 'Body Only',
                  muscles: GetMuscles(realExercises[i]['exercises']
                          ['exercise_muscle_groups']) ??
                      'none',
                  series: realExercises[i]['sets'],
                  reps: realExercises[i]['reps'],
                ),
                Review(
                  idExercise: realExercises[i]['id'] ?? 1,
                  idRoutine: args?['id'] ?? 1,
                  isLast: i == realExercises.length - 1,
                ),
              ],
            ],
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sizew * 0.25),
                child: ConfirmButton(
                  text: 'Next',
                  onPressed: () => nextPage(realExercises.length * 2 - 1),
                )),
          )
        ],
      ),
    );
  }

  String? GetMuscles(List<dynamic> muscles) {
    String? muscle;
    for (var m in muscles) {
      muscle ??= '';
      muscle += m['muscles']['name'] + ', ';
    }
    if (muscle != null && muscle.isNotEmpty) {
      muscle = muscle.substring(0, muscle.length - 2);
    }
    return muscle;
  }
}
