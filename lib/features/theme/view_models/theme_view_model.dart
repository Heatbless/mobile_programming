import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final themeViewModelProvider = StateNotifierProvider<ThemeViewModel, bool>((ref) {
  return ThemeViewModel();
});

class ThemeViewModel extends StateNotifier<bool> {
  ThemeViewModel() : super(false) {
    _loadThemePreference();
  }

  static const String _themeBox = 'theme_box';
  static const String _isDarkModeKey = 'is_dark_mode';

  Future<void> _loadThemePreference() async {
    final box = await Hive.openBox(_themeBox);
    state = box.get(_isDarkModeKey, defaultValue: false);
  }

  Future<void> toggleTheme() async {
    final box = await Hive.openBox(_themeBox);
    state = !state;
    await box.put(_isDarkModeKey, state);
  }
}