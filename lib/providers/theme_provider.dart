import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_theme.dart';

/// Theme provider to manage theme changes and persistence
class ThemeProvider with ChangeNotifier {
  static const String _themePrefsKey = 'theme_mode';
  
  // Default to system theme
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  // Current theme data based on brightness
  ThemeData get theme {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark ? AppTheme.dark() : AppTheme.light();
    }
    return _themeMode == ThemeMode.dark ? AppTheme.dark() : AppTheme.light();
  }
  
  // Check if current theme is dark
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
  
  // Initialize theme from saved preferences
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themePrefsKey);
    
    if (savedTheme != null) {
      _themeMode = _getThemeModeFromString(savedTheme);
      notifyListeners();
    }
  }
  
  // Set theme mode and save preference
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePrefsKey, _getStringFromThemeMode(mode));
  }
  
  // Toggle between light and dark themes
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.system) {
      // If current mode is system, toggle to explicit light/dark based on current brightness
      final isDark = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
      await setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
    } else {
      // Toggle between light and dark
      await setThemeMode(_themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }
  
  // Toggle between three modes: system, light, dark (cycles through them)
  Future<void> cycleThemeMode() async {
    ThemeMode nextMode;
    
    switch (_themeMode) {
      case ThemeMode.system:
        nextMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        nextMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        nextMode = ThemeMode.system;
        break;
    }
    
    await setThemeMode(nextMode);
  }
  
  // Helper methods for converting ThemeMode to/from string
  ThemeMode _getThemeModeFromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
  
  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}
