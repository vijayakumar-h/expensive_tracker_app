import 'package:flutter/material.dart';

abstract class SettingsRepository {
  String getLanguage();
  Future<void> saveLanguage(String languageCode);
  ThemeMode getTheme();
  Future<void> saveTheme(ThemeMode themeMode);
}
