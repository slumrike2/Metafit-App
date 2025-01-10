import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class Excersiceexpanded extends StatefulWidget {
  Excersiceexpanded({
    super.key,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.equipment,
    required this.muscles,
    required this.series,
    required this.reps,
    this.timer = true,
    this.time = 0,
  });

  final String name;
  final String description;
  final String difficulty;
  final String equipment;
  final String muscles;
  final int series;
  final int reps;
  int time;
  bool timer;

  @override
  State<Excersiceexpanded> createState() => _ExcersiceexpandedState();
}

class _ExcersiceexpandedState extends State<Excersiceexpanded> {
  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(16),
      child: Stack(
        children: [
          Container(
            height: sizeh * 0.7,
            width: double.infinity,
            margin: EdgeInsets.only(top: sizeh * 0.05 - 2),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                color: AppColors.secondary,
                width: 2,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextContent(context, 'Description', widget.description),
                  TextContent(context, 'Difficulty', widget.difficulty),
                  TextContent(context, 'Equipment', widget.equipment),
                  TextContent(context, 'Muscles', widget.muscles),
                  TextContent(context, 'Series', '${widget.series}'),
                  TextContent(context, 'Reps', '${widget.reps}'),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              height: sizeh * 0.05,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.secondary,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: AppColors.secondary,
                    width: 2,
                  ),
                  right: BorderSide(
                    color: AppColors.secondary,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                widget.name,
                textAlign: TextAlign.start,
                style: TextStyles.headline1(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (widget.timer)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: sizeh * 0.05,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: sizeh * 0.035,
                    ),
                    Text(
                      '${(widget.time ~/ 60).toString().padLeft(2, '0')}:${(widget.time % 60).toString().padLeft(2, '0')}',
                      style: TextStyles.headline3(context),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Container TextContent(BuildContext context, String text, String value) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyles.headline2(context),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: TextStyles.bodyMonseSmall(context),
          ),
        ],
      ),
    );
  }
}
