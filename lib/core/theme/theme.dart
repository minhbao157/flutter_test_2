//Flutter Package
import 'package:flutter/material.dart';

//Color Palette
import 'app_pallete.dart';

class AppTheme {
  static _border ([Color color = AppPallete.borderColor])=> OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppPallete.backgroundColor,
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
