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
      clipBehavior: Clip.none,
      children: [
        Container(
          width: sizew * 0.9,
          height: sizeh * 0.175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.secondary,
              width: 2,
            ),
            color: AppColors.primaryDark,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 32),
                    ),
                    Text(
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      margin: EdgeInsets.only(right: 7.5),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text(widget.difficulty)),
                    ),
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      margin: EdgeInsets.only(right: 7.5),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(
                              widget.cantExercises.toString() + ' exercises')),
                    ),
                    Container(
                      width: sizew * 0.2,
                      height: sizeh * 0.03,
                      margin: EdgeInsets.only(right: 7.5),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text(widget.equipment)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15,
          right: -15,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                widget.percentage,
                style: TextStyle(color: AppColors.complementary, fontSize: 32),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
