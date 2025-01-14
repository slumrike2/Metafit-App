import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/Components/HistoryWorkOutWidget.dart';
import 'package:frontmetafit/Components/RoutineWidget.dart';
import 'package:frontmetafit/Components/SumaryWidget.dart';
import 'package:frontmetafit/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  SupabaseClient supabase = Supabase.instance.client;
  String? userId;
  late Future<List<Map<String, dynamic>>> _workoutData;
  late Future<List<Map<String, dynamic>>> _progressData;
  late Future<List<Map<String, dynamic>>> _historyData;

  Future<List<Map<String, dynamic>>> fetchWorkoutData() async {
    while (true) {
      try {
        final response = await Supabase.instance.client
            .from('workouts')
            .select(
                '*, workout_exercises(*, exercises(*, exercise_muscle_groups(*,muscles(*)) ,exercise_equipment(*, equipment(*))))')
            .eq('user_id', userId!)
            .eq('created_at',
                DateTime.now().toIso8601String().split('T').first);

        final data = response as List<dynamic>;
        if (data.isNotEmpty) {
          return data as List<Map<String, dynamic>>;
        }
      } on Exception catch (e) {
        print('Error fetching workout data: $e');
      }
      await Future.delayed(Duration(seconds: 5));
    }
  }

  Future<List<Map<String, dynamic>>> fetchProgressData() async {
    // Implement the logic to fetch progress data
    final response = await supabase
        .from('users')
        .select('*, workouts(*,workout_exercises(*)), user_weights(*)')
        .eq('id', userId!)
        .eq('workouts.done', true);

    return response;
  }

  Future<List<Map<String, dynamic>>> fetchHistoryData() async {
    // Implement the logic to fetch history data
    final response = await supabase
        .from('workouts')
        .select('*,workout_rating(*)')
        .eq('user_id', userId!)
        .eq('done', true);
    return response;
  }

  Future<void> fetchIdealWeight() async {
    final _fbkey = GlobalKey<FormBuilderState>();

    final response = await supabase
        .from('users')
        .select('goal_weight')
        .eq('id', userId!)
        .single();

    final data = response;
    if (data == null || data['goal_weight'] == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Set Your Ideal Weight',
              style: TextStyles.headline1(context),
            ),
            content: FormBuilder(
              key: _fbkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBuilderTextField(
                    name: 'goal_weight',
                    decoration: InputDecoration(labelText: 'Goal Weight'),
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_fbkey.currentState!.saveAndValidate()) {
                            final idealWeight = _fbkey
                                .currentState!.fields['goal_weight']!.value;
                            await supabase.from('users').update(
                                {'goal_weight': idealWeight}).eq('id', userId!);

                            setState(() {
                              _workoutData = fetchWorkoutData();
                              _progressData = fetchProgressData();
                              _historyData = fetchHistoryData();
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    userId = supabase.auth.currentUser?.id;
    _workoutData = fetchWorkoutData();
    _progressData = fetchProgressData();
    _historyData = fetchHistoryData();
    fetchIdealWeight();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Routine of the Day',
                style: TextStyles.headline1(context),
                textAlign: TextAlign.start,
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _workoutData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      CircularProgressIndicator(
                        strokeCap: StrokeCap.butt,
                      ),
                      Text('Generating first routine...'),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('Loading routine...'));
                } else {
                  final workouts = snapshot.data!;
                  final todayWorkoutsSorted = workouts
                      .where((workout) => workout['recommendation'] != null)
                      .toList()
                    ..sort((a, b) =>
                        b['recommendation'].compareTo(a['recommendation']));
                  final firstWorkout = todayWorkoutsSorted.isNotEmpty
                      ? todayWorkoutsSorted[0]
                      : workouts[0];

                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RoutineWidget(
                      workoutData: firstWorkout,
                    ),
                  );
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Text(
                'Progress',
                style: TextStyles.headline1(context),
                textAlign: TextAlign.start,
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _progressData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('Loading progress...'));
                } else {
                  // Implement the UI for progress data
                  final data = snapshot.data![0];
                  final pesoActual = (data['weight'] ?? 0).toDouble();
                  final pesoIdeal =
                      (data['goal_weight'] ?? pesoActual).toDouble();
                  final ListaPesos = data['user_weights']
                    ..sort((a, b) => DateTime.parse(b['created_at'])
                        .compareTo(DateTime.parse(a['created_at'])));

                  final currentDate = DateTime.now();
                  final last4Months = List.generate(4, (index) {
                    final month = DateTime(
                        currentDate.year, currentDate.month - index, 1);
                    final weightEntry = ListaPesos.firstWhere(
                      (entry) =>
                          DateTime.parse(entry['created_at']).month ==
                          month.month,
                      orElse: () => {'weight': 0.0},
                    );
                    return FlSpot(
                      (3 - index).toDouble(),
                      (pesoIdeal > weightEntry['weight']
                          ? weightEntry['weight'].toDouble() / pesoIdeal
                          : pesoIdeal / weightEntry['weight'].toDouble()),
                    );
                  });

                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            CircularProgressBarWidget(
                                percentage: (pesoActual > pesoIdeal
                                        ? (pesoIdeal / pesoActual)
                                        : ((pesoActual as double) / pesoIdeal))
                                    .clamp(0.0, 1.0)
                                    .abs(),
                                size: sizeh * 0.15),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.secondary, width: 3),
                                ),
                                height: sizeh * 0.15,
                                width: sizew * 0.6,
                                padding: EdgeInsets.all(16),
                                child: LineChart(
                                  LineChartData(
                                    minX: 0,
                                    maxX: 3,
                                    minY: 0,
                                    maxY: 1,
                                    gridData: FlGridData(show: false),
                                    borderData: FlBorderData(show: false),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                        reservedSize: 22,
                                        showTitles: true,
                                        interval: 1,
                                        getTitlesWidget: (value, meta) {
                                          TextStyle style =
                                              TextStyles.bodyBebas(context);
                                          final monthNames = [
                                            'Jan',
                                            'Feb',
                                            'Mar',
                                            'Apr',
                                            'May',
                                            'Jun',
                                            'Jul',
                                            'Aug',
                                            'Sep',
                                            'Oct',
                                            'Nov',
                                            'Dec'
                                          ];
                                          final monthIndex =
                                              (currentDate.month -
                                                      (4 - value.toInt())) %
                                                  12;
                                          return Text(monthNames[monthIndex],
                                              style: style);
                                        },
                                      )),
                                      leftTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(),
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: last4Months,
                                        dotData: FlDotData(
                                          show: false,
                                        ),
                                        barWidth: 6,
                                        isStrokeCapRound: true,
                                        isCurved: true,
                                        color: AppColors.complementary,
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.complementary
                                                  .withOpacity(0.3),
                                              AppColors.complementary
                                                  .withOpacity(0.0),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SumaryWidget(
                          data: [
                            ElementosSumary(name: 'Name', value: 20),
                            ElementosSumary(
                                name: 'Email',
                                value: 50), // Assuming 0 for empty value
                            ElementosSumary(name: 'Shoulders', value: 25),
                            ElementosSumary(name: 'Weight', value: 75),
                            ElementosSumary(name: 'Height', value: 90),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Text(
                'History',
                style: TextStyles.headline1(context),
                textAlign: TextAlign.start,
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _historyData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('Loading history...'));
                } else {
                  // Implement the UI for history data
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 8,
                      children: [
                        for (var workout in snapshot.data!)
                          Historyworkoutwidget(
                            name: workout['name'],
                            stars: workout['workout_rating'] != null
                                ? workout['workout_rating']['routine_rating']
                                : '?',
                          ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  int CantExercises(List<dynamic> exercises) {
    int cantidad = 0;

    for (var exercise in exercises) {
      if (exercise['option'] == 1) {
        cantidad++;
      }
    }

    return cantidad;
  }

  @override
  bool get wantKeepAlive => true;
}
