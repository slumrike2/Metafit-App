import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/Components/HistoryWorkOutWidget.dart';
import 'package:frontmetafit/Components/RoutineWidget.dart';
import 'package:frontmetafit/Components/SumaryWidget.dart';
import 'package:frontmetafit/const.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
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
                  difficulty: 'hard',
                  cantExercises: 2,
                  equipment: 'none',
                  name: 'Shoulder Workout ',
                  description:
                      'Aqui va la descripcion del entrenamiento que deberia ser mas larga para ver como se ve en la pantalla y si se ajusta bien al espacio que se le asigno en el widget,quiero saber que pasa si me sobrepaso de esta mundicia',
                  percentage: '95%'),
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
                      percentage: 0.95, size: sizeh * 0.3),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.secondary, width: 3),
                      ),
                      height: sizeh * 0.135,
                      width: sizew * 0.6,
                      padding: EdgeInsets.all(16),
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const style = TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                );
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
                                    return Text('', style: style);
                                }
                              },
                            )),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
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
                ],
              ),
            ),
            SumaryWidget(
              data: [
                ElementosSumary(name: 'Name', value: 20),
                ElementosSumary(
                    name: 'Email', value: 50), // Assuming 0 for empty value
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
      ),
    );
  }
}
