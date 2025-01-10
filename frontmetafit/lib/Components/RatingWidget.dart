import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class Ratingwidget extends StatefulWidget {
  const Ratingwidget({super.key, required this.tittle});

  final String tittle;

  @override
  _RatingwidgetState createState() => _RatingwidgetState();
}

class _RatingwidgetState extends State<Ratingwidget> {
  double _currentRating = 0;

  @override
  void dispose() {
    imprimir();
    super.dispose();
  }

  imprimir() async {
    await Future.delayed(Duration(seconds: 3));
    print("Puntuacion a guardar: $_currentRating");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: AppColors.secondary),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryDark),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            widget.tittle,
            style: TextStyles.headline2(context),
          ),
          Slider(
            thumbColor: AppColors.complementary,
            activeColor: AppColors.complementary,
            value: _currentRating,
            min: 0,
            max: 1,
            divisions: 5,
            onChanged: (double value) {
              setState(() {
                _currentRating = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
