import 'package:flutter/material.dart';

class AppColors {
  static final Color primary = Color.fromARGB(255, 0, 0, 0);
  static final Color primaryDark = Color(0xFF191919);
  static final Color secondary = Color(0xFF404040);
  static final Color tertiary = Color(0xFF8C8C8C);
  static final Color quaternary = Color(0xFFBFBFBF);
  static final Color complementary = Color(0xFFF2F2F2);
}

class TextStyles {
  static TextStyle headline1(BuildContext context) {
    final sizeh = MediaQuery.of(context).size.height;
    return TextStyle(
      color: AppColors.complementary,
      fontSize: sizeh * 0.05, // Adjust the multiplier as needed
      fontWeight: FontWeight.bold,
    );
  }
}
