import 'package:flutter/material.dart';
import 'package:frontmetafit/Pages/Routine/routinePreview.dart';
import 'package:frontmetafit/const.dart';

class RoutineWidget extends StatelessWidget {
  final Map<String, dynamic> workoutData;

  RoutineWidget({required this.workoutData});

  void _navigateToNextPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routinepreview.routeName,
      arguments: workoutData, // Pasar workoutData como argumento
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    final exercises = workoutData['workout_exercises'] as List<dynamic>;
    final cantExercises =
        exercises.where((exercise) => exercise['option'] == 1).length;
    final percentage = (workoutData['recomendation'] * 100).toInt().toString();
    final equipment =
        (workoutData['equipment'] == 'yes') ? 'equipment' : 'body Only';
    final name = workoutData['name'];
    final difficulty = workoutData['difficulty'];
    final description = workoutData['description'];

    return GestureDetector(
      onTap: () => _navigateToNextPage(context),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: sizeh * 0.175,
            width: sizew * 0.9,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.secondary,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    name,
                    style: TextStyles.headline1(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    description,
                    overflow: TextOverflow.fade,
                    style: TextStyles.bodyMonseSmall(context),
                  ),
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(equipment,
                              style: TextStyles.bodyBebas(context))),
                    ),
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text('$cantExercises exercises',
                              style: TextStyles.bodyBebas(context))),
                    ),
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(difficulty,
                              style: TextStyles.bodyBebas(context))),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: -25,
            right: -25,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondary,
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  percentage.toString(),
                  style: TextStyles.headline1(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
