import 'package:expensive_tracker_app/common_exports.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;
  final ApiService apiService;

  SettingsRepositoryImpl({
    required this.localDataSource,
    required this.apiService,
  });

  @override
  String getLanguage() {
    final lang = localDataSource.getLanguage();
    apiService.setLanguage(lang);
    return lang;
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    await localDataSource.saveLanguage(languageCode);
    apiService.setLanguage(languageCode);
  }

  @override
  ThemeMode getTheme() {
    return localDataSource.getTheme();
  }

  @override
  Future<void> saveTheme(ThemeMode themeMode) async {
    await localDataSource.saveTheme(themeMode);
  }
}
