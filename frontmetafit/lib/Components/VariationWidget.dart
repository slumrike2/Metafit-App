import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class VariationWidget extends StatefulWidget {
  final Map<String, dynamic> exercise;
  final bool selected;
  final VoidCallback onPressed;

  VariationWidget({
    super.key,
    required this.exercise,
    this.selected = false,
    required this.onPressed,
  });

  @override
  State<VariationWidget> createState() => _VariationWidgetState();
}

class _VariationWidgetState extends State<VariationWidget> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;
    final exerciseData = widget.exercise['exercises'];
    final equipmentData = exerciseData['exercise_equipment']?.isNotEmpty == true
        ? exerciseData['exercise_equipment'].first['equipment']
        : null;

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
                  Container(
                    width: sizew * 0.6,
                    child: Text(
                      exerciseData['name'],
                      style: TextStyles.headline1(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                      onPressed: widget.onPressed,
                      icon: Icon(widget.selected
                          ? Icons.circle
                          : Icons.circle_outlined))
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                exerciseData['description'],
                overflow: TextOverflow.fade,
                style: TextStyles.bodyMonseSmall(context),
              ),
            ),
            Row(
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
                      child: Text('${widget.exercise['reps']} REPS',
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
                          equipmentData != null
                              ? equipmentData['name']
                              : 'body Only',
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
                      child: Text(exerciseData['difficulty'],
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
        child: Text('${widget.exercise['sets']} SETS',
            style: TextStyles.headline3(context), textAlign: TextAlign.center),
      )
    ]);
  }
}
