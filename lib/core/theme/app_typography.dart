import 'package:flutter/material.dart';

class AppTypography {
  static const String displayFont = 'Inter';
  static const String bodyFont = 'Inter';
  
  // ==================== DISPLAY STYLES ====================
  // Display - 56px / Bold
  static const TextStyle displayLarge = TextStyle(
    fontFamily: displayFont,
    fontSize: 56,
    fontWeight: FontWeight.bold,
    height: 1.1,
    letterSpacing: -0.5,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: displayFont,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.1,
    letterSpacing: -0.5,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontFamily: displayFont,
    fontSize: 40,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  // ==================== HEADLINE STYLES ====================
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: displayFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: displayFont,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: displayFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  
  // ==================== TITLE STYLES ====================
  static const TextStyle titleLarge = TextStyle(
    fontFamily: displayFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: displayFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontFamily: displayFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // ==================== BODY STYLES ====================
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: bodyFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  // ==================== LABEL STYLES ====================
  static const TextStyle labelLarge = TextStyle(
    fontFamily: bodyFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: bodyFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: bodyFont,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );

    static const TextStyle caption = TextStyle(
    fontFamily: bodyFont,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.3,
  );
}