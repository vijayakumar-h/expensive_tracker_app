import 'package:flutter/material.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

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
