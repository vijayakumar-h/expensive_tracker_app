import 'package:expensive_tracker_app/common_exports.dart';

abstract class SettingsLocalDataSource {
  String getLanguage();

  Future<void> saveLanguage(String languageCode);

  ThemeMode getTheme();

  Future<void> saveTheme(ThemeMode themeMode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final HiveService hiveService;

  SettingsLocalDataSourceImpl({required this.hiveService});

  @override
  String getLanguage() {
    return hiveService.get('languageCode')?.toString() ?? 'en';
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    await hiveService.store('languageCode', languageCode);
  }

  @override
  ThemeMode getTheme() {
    final String themeModeName =
        hiveService.get('themeValue')?.toString() ?? ThemeMode.system.name;
    return ThemeMode.values
        .singleWhere((element) => element.name == themeModeName);
  }

  @override
  Future<void> saveTheme(ThemeMode themeMode) async {
    await hiveService.store('themeValue', themeMode.name);
  }
}
