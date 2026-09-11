import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryDarkBlue = Color(0xFF003366);
  static const Color backgroundLight = Color(0xFFF5F7FA); // Soft background so the glass pops

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    primaryColor: primaryDarkBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDarkBlue,
      foregroundColor: Colors.white, // White text on dark blue app bar
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryDarkBlue),
    useMaterial3: true,
  );
}