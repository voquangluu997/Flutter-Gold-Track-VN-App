import 'package:flutter/material.dart';

class AppColors {
  // ==================== GOLD LUXE THEME ====================
  static const Color goldLight = Color(0xFFFFD700);
  static const Color goldMain = Color(0xFFDAA520);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color goldAccent = Color(0xFFFFC107);
  static const Color brownLight = Color(0xFFD2B48C);
  static const Color brownMain = Color(0xFF8B4513);
  static const Color goldBackground = Color(0xFFFFFDF7);
  static const Color goldSurface = Color(0xFFFFFFFF);
  static const Color goldSurfaceVariant = Color(0xFFF5F0E8);
  static const Color goldTextPrimary = Color(0xFF3D2B1F);
  static const Color goldTextSecondary = Color(0xFF8B7355);
  static const Color goldTextHint = Color(0xFFC4B5A0);
  static const Color goldPriceBuy = Color(0xFF2E7D32);
  static const Color goldPriceSell = Color(0xFFC62828);
  
  static const LinearGradient goldPrimaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldLight, goldMain, goldDark],
    stops: [0.0, 0.5, 1.0],
  );
  
  // ==================== ETHEREAL PULSE THEME ====================
  static const Color lavender = Color(0xFF6C5CE7);
  static const Color coral = Color(0xFFFF6B6B);
  static const Color mint = Color(0xFF00B894);
  static const Color cyan = Color(0xFF00D2FF);
  static const Color yellow = Color(0xFFFFE66D);
  static const Color rose = Color(0xFFFF7675);
  static const Color etherealPrimary = Color(0xFF5948D3);
  // static const Color etherealBackground = Color(0xFF0D0D1A);
  static const Color etherealBackground = Color(0xFFF9F9FF);


  // static const Color etherealSurface = Color(0xFF1A1A2E);

  static const Color etherealSurfaceVariant = Color(0xFF252542);
  static const Color etherealTextPrimary = Color(0xFFFFFFFF);
  static const Color etherealTextSecondary = Color(0xFFA0A0B8);
  static const Color etherealTextHint = Color(0xFF6C6C8A);
  static const Color etherealPriceBuyBg = Color(0xFFDBFDF3);
  static const Color etherealPriceSellBg = Color(0xFFFCE7E9);
  static const Color etherealPriceBuy = Color(0xFF4DB995);
  static const Color etherealPriceSell = Color(0xFFF47474);
  static const Color etherealSupperWhite = Color(0xFFFFFFFF);
  static const Color etherealSurface = Color(0xFFF9F9FF);
  static const Color dark = Color(0xFF2E3A3A);

  
  // ✅ Gradient chính cho Ethereal Theme (có thể tái sử dụng)
  static const LinearGradient etherealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lavender, coral],
  );
  
  // ✅ Gradient đầy đủ 4 màu
  static const LinearGradient etherealFullGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lavender, coral, cyan, yellow],
  );
  
  // static const LinearGradient etherealCardGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [etherealSurface, etherealSurfaceVariant],
  // );
}