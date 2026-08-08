import 'dart:io';
import 'package:expensive_tracker_app/core/network/api_service.dart';
import 'package:expensive_tracker_app/core/services/service_locator.dart';
import 'package:expensive_tracker_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:expensive_tracker_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:expensive_tracker_app/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('Feature-First Clean Architecture GetIt initialization test', () async {
    final tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);

    await sl.reset();
    await initServiceLocator();

    expect(sl.isRegistered<ApiService>(), isTrue);
    expect(sl.isRegistered<ExpenseRepository>(), isTrue);
    expect(sl.isRegistered<SettingsRepository>(), isTrue);
    expect(sl.isRegistered<UserRepository>(), isTrue);

    final apiService = sl<ApiService>();
    expect(apiService.headers['Accept-Language'], equals('en'));

    await sl<SettingsRepository>().saveLanguage('hi');
    expect(apiService.headers['Accept-Language'], equals('hi'));
  });
}
