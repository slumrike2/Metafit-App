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

  Future<List<Map<String, dynamic>>> fetchWorkoutData() async {
    final response = await Supabase.instance.client
        .from('workouts')
        .select('*, workout_exercises(*, exercises(*, exercise_equipment(*, equipment(*))))')
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id);

    final data = response as List<dynamic>;
    if (data.isEmpty) {
      throw Exception('No workout data available');
    }

    return data as List<Map<String, dynamic>>;
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _workoutData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No workout data available'));
          } else {
            final workouts = snapshot.data!;
            final firstWorkout = workouts[0];
            final otherWorkouts = workouts.sublist(1);
            return Column(
              children: [
                Column(
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
