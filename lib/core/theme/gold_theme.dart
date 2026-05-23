import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class GoldTheme {
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.goldMain,
    scaffoldBackgroundColor: AppColors.goldBackground,
    
    colorScheme: const ColorScheme.dark(
      primary: AppColors.goldMain,
      secondary: AppColors.brownLight,
      surface: AppColors.goldSurface,
      error: AppColors.goldPriceSell,
      onPrimary: Colors.white,
      onSecondary: AppColors.goldTextPrimary,
      onSurface: AppColors.goldTextPrimary,
    ),
    
    fontFamily: AppTypography.bodyFont,
    
    textTheme: const TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelSmall: AppTypography.caption,
    ),
    
    cardTheme: CardThemeData(
      elevation: 4,
      color: AppColors.goldSurface,
      shadowColor: AppColors.goldLight.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.goldMain,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.goldMain,
        side: const BorderSide(color: AppColors.goldMain, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.goldLight.withValues(alpha: 0.15),
      labelStyle: AppTypography.bodySmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: BorderSide.none,
    ),
  );
}