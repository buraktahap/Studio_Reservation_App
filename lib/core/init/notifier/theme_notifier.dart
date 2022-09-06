import 'package:flutter/material.dart';

import '../../constants/enums/app_theme_enums.dart';
import '../theme/app_theme_light.dart';
import 'IThemeNotifier.dart';

class ThemeNotifier extends ChangeNotifier implements IThemeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;

  AppThemes _currentThemeEnum = AppThemes.light;

  /// Application theme enum.
  /// Defaut value is [AppThemes.light]
  AppThemes get currentThemeEnum => _currentThemeEnum;
  ThemeData get currentTheme => _currentTheme;

  @override
  void changeValue(AppThemes theme) {
    if (theme == AppThemes.light) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }

  /// Change your app theme with [currentThemeEnum] value.
  void changeTheme() {
    if (_currentThemeEnum == AppThemes.light) {
      _currentTheme = ThemeData.dark();
      _currentThemeEnum = AppThemes.dark;
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currentThemeEnum = AppThemes.light;
    }
    notifyListeners();
  }
}
