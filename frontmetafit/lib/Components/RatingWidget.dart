import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Define the enum Type
enum Type {
  Exercise,
  Routine_Difficulty,
  Routine_Rating,
}

class Ratingwidget extends StatefulWidget {
  const Ratingwidget(
      {super.key,
      required this.tittle,
      required this.idWidget,
      required this.idRoutine,
      required this.type});

  final String tittle;
  final int idWidget;
  final int idRoutine;
  final Type type; // Change type to use the enum

  @override
  _RatingwidgetState createState() => _RatingwidgetState();
}

class _RatingwidgetState extends State<Ratingwidget> {
  double _currentRating = 0;
  SupabaseClient supabase = Supabase.instance.client;

  @override
  void dispose() {
    Save();
    super.dispose();
  }

  Save() async {
    if (widget.type == Type.Exercise) {
      try {
        await supabase.from('workout_exercise_rating').upsert({
          'workout_exercise_id': widget.idWidget,
          'rating': _currentRating.toInt(),
        });
      } on Exception catch (e) {
        print(e.toString());
      }
    } else if (widget.type == Type.Routine_Difficulty) {
      try {
        print(widget.idRoutine);
        await supabase.from('workout_rating').upsert({
          'workout_id': widget.idRoutine,
          'difficulty_rating': _currentRating.toInt(),
        });
      } catch (e) {
        print(e.toString());
      }
      // Save the rating for the routine difficulty
    } else if (widget.type == Type.Routine_Rating) {
      try {
        print(widget.idRoutine);
        await supabase.from('workout_rating').upsert({
          'workout_id': widget.idRoutine,
          'routine_rating': _currentRating.toInt(),
        });
      } catch (e) {
        print(e.toString());
      }
      // Save the rating for the routine
    }
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
            max: 5,
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
