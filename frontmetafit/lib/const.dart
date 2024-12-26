import 'package:flutter/material.dart';

class AppColors {
  static final Color primary = Color.fromARGB(255, 0, 0, 0);
  static final Color primaryDark = Color(0xFF191919);
  static final Color secondary = Color(0xFF404040);
  static final Color tertiary = Color(0xFF8C8C8C);
  static final Color quaternary = Color(0xFFBFBFBF);
  static final Color complementary = Color(0xFFF2F2F2);
}

class textstyles {
  //!AGREGAR TODOS LOS TEXTSTYLES QUE SE NECESITEN

  static final TextStyle headline1 = TextStyle(
    //! this should be consistent with de sizeh 
    color: AppColors.complementary,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
}
