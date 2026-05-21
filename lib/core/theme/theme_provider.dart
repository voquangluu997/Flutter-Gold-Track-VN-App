import 'package:flutter/material.dart';
import 'gold_theme.dart';
import 'ethereal_theme.dart';

enum AppThemeType { ethereal, gold }

class ThemeProvider extends ChangeNotifier {
  AppThemeType _currentTheme = AppThemeType.ethereal;
  
  AppThemeType get currentTheme => _currentTheme;
  
  ThemeData get currentThemeData {
    switch (_currentTheme) {
      case AppThemeType.gold:
        return GoldTheme.dark;
      case AppThemeType.ethereal:
        return EtherealTheme.light;
    }
  }
  
  void setTheme(AppThemeType theme) {
    _currentTheme = theme;
    notifyListeners();
  }
  
  void toggleTheme() {
    if (_currentTheme == AppThemeType.ethereal) {
      _currentTheme = AppThemeType.gold;
    } else {
      _currentTheme = AppThemeType.ethereal;
    }
    notifyListeners();
  }
}