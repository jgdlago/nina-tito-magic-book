import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      textTheme: GoogleFonts.cinzelTextTheme().merge(
        const TextTheme(
          titleMedium: TextStyle(fontSize: 30, color: AppColors.mysticalBlack),
        ),
      ),
    );
  }
}
