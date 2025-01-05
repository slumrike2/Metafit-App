import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class Historyworkoutwidget extends StatelessWidget {
  const Historyworkoutwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    return IntrinsicWidth(
      child: Container(
        width: sizew * 0.4,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.secondary,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              'Shoulder Workout',
              textAlign: TextAlign.center,
              style: TextStyles.headline3(context),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '2/5',
                  textAlign: TextAlign.center,
                  style: TextStyles.headline3(context),
                ),
                Icon(Icons.star_border),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
