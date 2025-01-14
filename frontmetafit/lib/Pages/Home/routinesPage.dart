import 'dart:math';

import 'package:flutter/material.dart';

import 'package:frontmetafit/Components/RoutineWidget.dart';
import 'package:frontmetafit/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  late Future<List<Map<String, dynamic>>> _workoutData;

  @override
  void initState() {
    super.initState();
    _workoutData = fetchWorkoutData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutData() async {
    while (true) {
      final response = await Supabase.instance.client
          .from('workouts')
          .select(
              '*, workout_exercises(*, exercises(*, exercise_muscle_groups(*,muscles(*)) ,exercise_equipment(*, equipment(*))))')
          .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
          .eq('created_at', DateTime.now().toIso8601String().split('T').first);

      final data = response as List<dynamic>;

      if (!data.isEmpty) {
        return data as List<Map<String, dynamic>>;
      }
      await Future.delayed(Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _workoutData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Loading routines...'),
                    ],
                  )),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No workout data available'));
          } else {
            final workouts = snapshot.data!;

            workouts.sort(
                (a, b) => b['recomendation'].compareTo(a['recomendation']));

            final firstWorkout = workouts[0];
            final otherWorkouts = workouts.sublist(1);
            return Column(
              children: [
                Column(
                  spacing: 16,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 32),
                      child: Text('Routines of the day',
                          style: TextStyles.headline1(context)),
                    ),
                    RoutineWidget(
                      workoutData: firstWorkout,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 32, top: 40),
                  child: Text('Other Routines',
                      style: TextStyles.headline1(context),
                      textAlign: TextAlign.left),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      spacing: 16,
                      children: [
                        for (var workout in otherWorkouts)
                          RoutineWidget(
                            workoutData: workout,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  int CantExercises(List<dynamic> exercises) {
    int cantidad = 0;

    for (var exercise in exercises) {
      print(exercise['option']);
      if (exercise['option'] == 1) {
        cantidad++;
      }
    }

    return cantidad;
  }
}
