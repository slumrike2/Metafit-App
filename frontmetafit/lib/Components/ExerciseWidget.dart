import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class Exercisewidget extends StatelessWidget {
  final int reps;
  final int sets;
  final double time;
  final String equipment;
  final String name;
  final String difficulty;
  final String description;

  Exercisewidget({
    super.key,
    this.reps = 0,
    required this.sets,
    required this.equipment,
    required this.name,
    required this.difficulty,
    required this.description,
    this.time = 0,
  });

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    return Stack(alignment: AlignmentDirectional.topEnd, children: [
      Container(
        height: sizeh * 0.2,
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
              child: Row(
                children: [
                  Text(
                    'Exercise Widget',
                    style: TextStyles.headline1(context),
                  ),
                  IconButton(
                      onPressed: () {
                        print('hola');
                      },
                      icon: Icon(Icons.arrow_circle_right))
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit voluptate velit esse cillum dolore fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt culpa qui officia deserunt mollit anim id est laborum',
                overflow: TextOverflow.fade,
                style: TextStyles.bodyMonseSmall(context),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 7.5,
              children: [
                Container(
                  width: sizew * 0.2,
                  height: sizeh * 0.03,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Text(
                          time > 0
                              ? time.toString() + ' SEC'
                              : reps.toString() + ' REPS',
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
                      child: Text(difficulty,
                          style: TextStyles.bodyBebas(context))),
                ),
              ],
            )
          ],
        ),
      ),
      Container(
        height: sizeh * 0.04,
        width: sizew * 0.2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          border: Border.all(
            color: AppColors.secondary,
            width: 2,
          ),
        ),
        child: Text('$sets SETS',
            style: TextStyles.headline3(context), textAlign: TextAlign.center),
      )
    ]);
  }
}
