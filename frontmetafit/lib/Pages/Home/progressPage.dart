import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  SupabaseClient supabase = Supabase.instance.client;
  String? userId = Supabase.instance.client.auth.currentUser?.id;

  Future<List<Map<String, dynamic>>> _loadData() async {
    // Implement the logic to fetch progress data
    final response = await supabase
        .from('users')
        .select('*, workouts(*,workout_exercises(*)), user_weights(*)')
        .eq('id', userId!)
        .eq('workouts.done', true);
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;
    return FutureBuilder<List<dynamic>>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else {
          final data = snapshot.data![0];
          final goal_weight = data['goal_weight'] ?? data['weight'];

          final pesoActual = (data['weight'] ?? 0).toDouble();
          final pesoIdeal = (data['goal_weight'] ?? pesoActual).toDouble();

          final ListaPesos = data['user_weights']
            ..sort((a, b) => DateTime.parse(b['created_at'])
                .compareTo(DateTime.parse(a['created_at'])));

          final currentDate = DateTime.now();
          final last4Months = List.generate(4, (index) {
            final month =
                DateTime(currentDate.year, currentDate.month - index, 1);
            final weightEntry = ListaPesos.firstWhere(
              (entry) =>
                  DateTime.parse(entry['created_at']).month == month.month,
              orElse: () => {'weight': 0.0},
            );
            return FlSpot(
              (3 - index).toDouble(),
              (pesoIdeal > weightEntry['weight']
                  ? weightEntry['weight'].toDouble() / pesoIdeal
                  : pesoIdeal / weightEntry['weight'].toDouble()),
            );
          });

          int calcularRacha() {
            int streak = 0;
            final workouts = data['workouts']
                .where((workout) => workout['done'] == true)
                .toList()
              ..sort((a, b) => DateTime.parse(b['created_at'])
                  .compareTo(DateTime.parse(a['created_at'])));

            DateTime? lastDate;

            for (var workout in workouts) {
              final workoutDate =
                  DateTime.parse(workout['created_at']).toLocal();

              if (lastDate == null) {
                lastDate = workoutDate;
                streak++;
              } else {
                final difference = lastDate.difference(workoutDate).inDays;
                if (difference == 1) {
                  streak++;
                  lastDate = workoutDate;
                } else if (difference > 1) {
                  break;
                }
              }
            }

            return streak;
          }

          int totalExercisesMade = data['workouts'] != null
              ? data['workouts'] != null && data['workouts'].isNotEmpty
                  ? data['workouts']
                      .map((workout) => workout['workout_exercises'].length)
                      .reduce((a, b) => a + b)
                  : 0
              : 0;

          int routinesCompleted =
              data['workouts'] != null ? data['workouts'].length : 0;

          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularProgressBarWidget(
                          percentage: data['goal_weight'] == null ||
                                  data['goal_weight'] == 0
                              ? 1
                              : data['weight'] > data['goal_weight']
                                  ? data['goal_weight'] / data['weight']
                                  : data['weight'] / data['goal_weight'],
                          size: sizew * 0.45,
                          text: 'Goal Progress',
                        ),
                        Container(
                          width: sizew * 0.45,
                          height: sizew * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.secondary,
                              width: 3,
                            ),
                            color: AppColors.primaryDark,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: double.infinity,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    calcularRacha().toString(),
                                    style: TextStyle(
                                      fontSize: sizeh * 0.15,
                                      color: AppColors.complementary,
                                      fontFamily: 'BebasNeue',
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'Streak',
                                  style: TextStyles.headline1(context),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.secondary, width: 3),
                      ),
                      height: sizeh * 0.15,
                      width: sizew,
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
                                  final monthIndex = (DateTime.now().month -
                                          (4 - value.toInt())) %
                                      12;
                                  return Text(monthNames[monthIndex],
                                      style: style);
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: last4Months,
                              dotData: FlDotData(show: false),
                              barWidth: 6,
                              isStrokeCapRound: true,
                              isCurved: true,
                              color: AppColors.complementary,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.complementary.withOpacity(0.3),
                                    AppColors.complementary.withOpacity(0.0),
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: sizeh * 0.1,
                              height: sizeh * 0.1,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryDark,
                                border: Border.all(
                                  color: AppColors.complementary,
                                  width: sizeh * 0.01,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                totalExercisesMade.toString(),
                                style: TextStyles.headline1(context),
                              ),
                            ),
                            Text(
                              'Total Exercises Made',
                              style: TextStyles.headline2(context),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: sizeh * 0.1,
                              height: sizeh * 0.1,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryDark,
                                border: Border.all(
                                  color: AppColors.complementary,
                                  width: sizeh * 0.01,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                routinesCompleted.toString(),
                                style: TextStyles.headline1(context),
                              ),
                            ),
                            Text(
                              'Routines Completed',
                              style: TextStyles.headline2(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
