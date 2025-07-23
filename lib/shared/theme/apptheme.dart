import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xff171717);
  static Color secondary = Color(0xffFFFFFF);
  static Color gray = Color(0xffA0A0A0);
  static Color red = Color.fromARGB(255, 213, 0, 0);

  static ThemeData lighttheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: secondary,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: secondary,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: primary,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: primary,
      foregroundColor: secondary,
      shape: CircleBorder(side: BorderSide(width: 5, color: secondary)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: secondary,
      unselectedItemColor: secondary,
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        color: secondary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(color: secondary, fontSize: 22),
      headlineLarge: TextStyle(
        color: primary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        color: primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
        decorationColor: AppTheme.primary,
        decorationThickness: 1.5,
      ),
      bodySmall: TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: primary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: secondary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
