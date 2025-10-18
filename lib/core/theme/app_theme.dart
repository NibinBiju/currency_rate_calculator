import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );

  // ThemeData(

  //   iconTheme: IconThemeData(color: AppColors.accentDark),
  //   splashColor: Colors.transparent,
  //   primaryColor: AppColors.primary,
  //   scaffoldBackgroundColor: AppColors.primary,
  //   brightness: Brightness.light,
  //   fontFamily: 'Poppins',
  //   hintColor: AppColors.accentBlue,
  //   textSelectionTheme: TextSelectionThemeData(
  //     cursorColor: AppColors.accentBlue,
  //   ),

  //   appBarTheme: const AppBarTheme(
  //     iconTheme: IconThemeData(color: AppColors.accentDark),
  //   ),

  // );
}
