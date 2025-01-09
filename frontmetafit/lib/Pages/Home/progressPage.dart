import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/const.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;
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
                  percentage: 0.7, size: sizew * 0.45, text: 'Progress'),
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
                          '52',
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
                    )
                  ],
                ),
              ),
            ],
          )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.secondary, width: 3),
              ),
              height: sizeh * 0.15,
              width: sizew,
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
                        TextStyle style = TextStyles.bodyBebas(context);
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
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                          color: AppColors.complementary, width: sizeh * 0.01),
                    ),
                    alignment: Alignment.center,
                    child: Text('10', style: TextStyles.headline1(context)),
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
                          color: AppColors.complementary, width: sizeh * 0.01),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '20',
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
          ))
        ],
      ),
    ));
  }
}
