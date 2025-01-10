import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/CircularProgressBarWidget.dart';
import 'package:frontmetafit/Components/RatingWidget.dart';
import 'package:frontmetafit/const.dart';

class Review extends StatefulWidget {
  Review(
      {super.key,
      required this.idExercise,
      required this.idRoutine,
      this.isLast = false});
  final int idExercise;
  final int idRoutine;
  bool isLast;

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Container(
              width: double.infinity,
              child: Text(
                widget.isLast ? 'Good Job Routine Finished' : 'Rest',
                style: TextStyles.headline1(context),
              )),
          widget.isLast
              ? (Ratingwidget(
                  tittle: "Routine Difficulty",
                ))
              : CircularProgressBarWidget(
                  percentage: 0.7,
                  countdown: true,
                  size: sizew,
                ),
          widget.isLast
              ? Ratingwidget(
                  tittle: "Rutine rating",
                )
              : Container(),
          Ratingwidget(
            tittle: "exercise rating",
          ),
        ],
      ),
    );
  }
}
