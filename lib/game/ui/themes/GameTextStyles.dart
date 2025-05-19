import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../presentation/theme/AppColors.dart';

class GameTextStyles {
   // AppThemes -> titleMedium,
  static final TextStyle dialogTitle = GoogleFonts.rampartOne(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.mysticalBlack,
  );

  // AppThemes -> bodySmall,
  static final TextStyle dialogBody = GoogleFonts.quicksand(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: AppColors.mysticalBlack,
  );

  static final TextStyle levelMessageTitle = GoogleFonts.quicksand(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.goldenMagic,
    shadows: [
      Shadow(offset: Offset( 1,  1), blurRadius: 1, color: AppColors.mysticalBlack),
    ],
  );

  static final TextStyle levelMessageBody = GoogleFonts.quicksand(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.goldenMagic,
    shadows: [
      Shadow(offset: Offset( 1,  1), blurRadius: 1, color: AppColors.mysticalBlack),
    ],
  );
}
