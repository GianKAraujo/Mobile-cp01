import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get tema {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.roxo,
        primary: AppColors.roxo,
        surface: AppColors.papel,
      ),
      scaffoldBackgroundColor: AppColors.papel,
    );

    return base.copyWith(
      textTheme: GoogleFonts.latoTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.roxo,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
