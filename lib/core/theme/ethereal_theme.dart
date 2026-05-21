import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class EtherealTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.etherealPrimary,
    scaffoldBackgroundColor: AppColors.etherealSurface,
    
    colorScheme: const ColorScheme.light(
      primary: AppColors.etherealPrimary,
      secondary: AppColors.coral,
      surface: AppColors.etherealSurface,
      error: AppColors.rose,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.etherealTextPrimary,
    ),
    
    fontFamily: AppTypography.bodyFont,
    
    textTheme: const TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelSmall: AppTypography.labelSmall,
    ),
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.etherealPrimary,
      foregroundColor: Colors.white,
      centerTitle: false,
    ),
    
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.etherealSupperWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.etherealPrimary,
        foregroundColor: AppColors.lavender,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.coral,
        side: const BorderSide(color: AppColors.coral, width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.etherealSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.lavender, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.etherealTextHint),
    ),
    
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.etherealSurfaceVariant,
      selectedColor: AppColors.lavender,
      labelStyle: AppTypography.labelSmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: BorderSide.none,
    ),
    
    dividerTheme: const DividerThemeData(
      color: AppColors.etherealSurfaceVariant,
      thickness: 1,
      space: 1,
    ),
  );
}