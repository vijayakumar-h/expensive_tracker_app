import 'dart:io';
import 'package:expensive_tracker_app/src/services/api_service.dart';
import 'package:expensive_tracker_app/src/services/hive_service.dart';
import 'package:expensive_tracker_app/src/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:expensive_tracker_app/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('Native Repository and ApiService test without GetIt', () async {
    final tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);

    final apiService = ApiService();
    final hiveService = HiveService();
    await hiveService.init();

    final settingsLocalDataSource = SettingsLocalDataSourceImpl(hiveService: hiveService);
    final settingsRepository = SettingsRepositoryImpl(
      localDataSource: settingsLocalDataSource,
      apiService: apiService,
    );

    expect(apiService.headers['Accept-Language'], equals('en'));

    await settingsRepository.saveLanguage('hi');
    expect(apiService.headers['Accept-Language'], equals('hi'));
  });
}
