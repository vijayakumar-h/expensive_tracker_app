import 'package:expensive_tracker_app/common_exports.dart';

abstract class SettingsRepository {
  String getLanguage();
  Future<void> saveLanguage(String languageCode);
  ThemeMode getTheme();
  Future<void> saveTheme(ThemeMode themeMode);
}
