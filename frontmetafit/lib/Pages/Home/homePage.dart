import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/Components/HistoryWorkOutWidget.dart';
import 'package:frontmetafit/Components/RoutineWidget.dart';
import 'package:frontmetafit/Components/SumaryWidget.dart';
import 'package:frontmetafit/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    userId = supabase.auth.currentUser?.id;
    _workoutData = fetchWorkoutData();
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutData() async {
    final response = await Supabase.instance.client
        .from('workouts')
        .select(
            '*, workout_exercises(*, exercises(*, exercise_equipment(*, equipment(*))))')
        .eq('user_id', userId!);

    final data = response as List<dynamic>;
    if (data.isEmpty) {
      throw Exception('No workout data available');
    }
    return data as List<Map<String, dynamic>>;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

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
            final exercises =
                firstWorkout['workout_exercises'] as List<dynamic>;

            return Padding(
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
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: RoutineWidget(
                      workoutData: firstWorkout,
                    ),
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
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      spacing: 8,
                      children: [
                        CircularProgressBarWidget(
                            percentage: 0.95, size: sizeh * 0.15),
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
                                maxX: 6,
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
                                      switch (value.toInt()) {
                                        case 0:
                                          return Text('Mon', style: style);
                                        case 1:
                                          return Text('Tue', style: style);
                                        case 2:
                                          return Text('Wed', style: style);
                                        case 3:
                                          return Text('Thu', style: style);
                                        case 4:
                                          return Text('Fri', style: style);
                                        case 5:
                                          return Text('Sat', style: style);
                                        case 6:
                                          return Text('Sun', style: style);
                                        default:
                                          return Container(); // Return an empty container for out of range values
                                      }
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
                                    spots: [
                                      FlSpot(0, 0.5),
                                      FlSpot(1, 0.6),
                                      FlSpot(2, 0.7),
                                      FlSpot(3, 0.8),
                                      FlSpot(4, 0.3),
                                      FlSpot(5, 1),
                                      FlSpot(6, 0.1),
                                    ],
                                    dotData: FlDotData(
                                      show: false,
                                    ),
                                    barWidth: 5,
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
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    child: Text(
                      'History',
                      style: TextStyles.headline1(context),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: [
                          Historyworkoutwidget(),
                          Historyworkoutwidget(),
                          Historyworkoutwidget(),
                        ],
                      )),
                ],
              ),
            );
          }
        },
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
