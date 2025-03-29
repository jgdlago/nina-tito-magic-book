import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      textTheme: GoogleFonts.fredokaTextTheme().copyWith(
        titleMedium: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.mysticalBlack,
        ),
        bodySmall: GoogleFonts.quicksand(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: AppColors.mysticalBlack,
        ),
      ),
    );
  }
}
