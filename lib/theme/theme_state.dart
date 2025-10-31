import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppTheme.lightTheme) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';
  late SharedPreferences _prefs;

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs.getBool(_themeKey) ?? false;
    state = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  Future<void> toggleTheme() async {
    final isDark = state == AppTheme.darkTheme;
    state = isDark ? AppTheme.lightTheme : AppTheme.darkTheme;
    await _prefs.setBool(_themeKey, !isDark);
  }

  bool get isDarkMode => state == AppTheme.darkTheme;
}