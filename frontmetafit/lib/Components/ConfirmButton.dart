import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class ConfirmButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const ConfirmButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    final sizew = MediaQuery.of(context).size.width;

    return SizedBox(
      width: sizew * 0.5,
      height: sizeh * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: AppColors.secondary,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.complementary,
          ),
        ),
      ),
    );
  }
}
