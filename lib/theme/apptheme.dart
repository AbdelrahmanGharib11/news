import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xff171717);
  static Color secondary = Color(0xffFFFFFF);
  static Color gray = Color(0xffA0A0A0);

  static ThemeData darktheme = ThemeData(
    scaffoldBackgroundColor: primary,

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: secondary),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: secondary),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: secondary),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: primary,
        fontSize: 36,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w500, //medium font
      ),
      displayMedium: TextStyle(
        color: primary,
        fontSize: 24,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w700, // bold font
      ),
      displaySmall: TextStyle(
        color: primary,
        fontSize: 20,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w700, // bold font
      ),
      titleLarge: TextStyle(
        color: primary,
        fontSize: 20,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w600, // semi-bold font
      ),
      titleMedium: TextStyle(
        color: primary,
        fontSize: 20,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w400, // regular font
      ),
      titleSmall: TextStyle(
        color: primary,
        fontSize: 16,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w400, // regular font
      ),
      bodyLarge: TextStyle(
        color: primary,
        fontSize: 14,
        fontFamily: 'myFonst',
        fontWeight: FontWeight.w400, // regular font
      ),
      bodyMedium: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w900, // Black font
      ),
      bodySmall: TextStyle(
        color: primary,
        fontSize: 15,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w400, // regular font
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
  );
}
