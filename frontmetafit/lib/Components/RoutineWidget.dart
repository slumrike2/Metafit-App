import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class RoutineWidget extends StatefulWidget {
  final String difficulty;
  final int cantExercises;
  final String equipment;
  final String name;
  final String description;
  final String percentage;

  const RoutineWidget({
    super.key,
    required this.difficulty,
    required this.cantExercises,
    required this.equipment,
    required this.name,
    required this.description,
    required this.percentage,
  });

  @override
  State<RoutineWidget> createState() => _RoutineWidgetState();
}

class _RoutineWidgetState extends State<RoutineWidget> {
  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
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
                  child: Text(
                    widget.name,
                    style: TextStyles.headline1(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.description,
                    overflow: TextOverflow.fade,
                    style: TextStyles.bodyMonseSmall(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(widget.equipment,
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
                          child: Text(
                              '${widget.cantExercises} exercises',
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
                          child: Text(widget.difficulty,
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
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondary,
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  widget.percentage,
                  style: TextStyles.headline3(context),
                ),
              ),
            ),
          ),
        ]);
  }
}
