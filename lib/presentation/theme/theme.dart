import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      textTheme: GoogleFonts.fredokaTextTheme().copyWith(
        titleMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.mysticalBlack,
        ),
        bodyMedium: GoogleFonts.quicksand(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: AppColors.mysticalBlack,
        ),
        bodySmall: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.mysticalBlack,
        ),
      ),
    );
  }
}
