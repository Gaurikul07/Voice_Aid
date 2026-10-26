import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const teal = Color(0xFF00695C);
  static const tealDark = Color(0xFF004D40);
  static const warmWhite = Color(0xFFFFFBF5);
  static const card = Color(0xFFFFFFFF);
  static const danger = Color(0xFFB3261E);
  static const dangerBg = Color(0xFFFDECEA);
  static const warnBg = Color(0xFFFFF4D6);
  static const text = Color(0xFF1B1B1B);
}

class AppTheme {
  AppTheme._();

  /// Minimum touch target height used across the app (Material minimum is 48).
  static const double minTouch = 56;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.teal,
      primary: AppColors.teal,
      surface: AppColors.warmWhite,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.warmWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.warmWhite,
        foregroundColor: AppColors.text,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.text),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.text),
        titleMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: AppColors.text),
        bodyLarge: TextStyle(fontSize: 20, height: 1.45, color: AppColors.text),
        bodyMedium: TextStyle(fontSize: 17, height: 1.4, color: AppColors.text),
        labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, minTouch),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, minTouch),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          side: const BorderSide(color: AppColors.teal, width: 2),
          foregroundColor: AppColors.tealDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
