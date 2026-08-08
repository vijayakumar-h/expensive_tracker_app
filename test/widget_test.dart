import 'dart:io';
import 'package:expensive_tracker_app/src/utils/common_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ApiService and GetIt singletons initialization test', () async {
    final tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);

    await sl.reset();
    await initServiceLocator();

    expect(sl.isRegistered<ApiService>(), isTrue);
    expect(sl.isRegistered<AppRepository>(), isTrue);
    expect(sl.isRegistered<AuthRepository>(), isTrue);

    // Verify ApiService header initialization
    final apiService = sl<ApiService>();
    expect(apiService.headers['Accept-Language'], equals('en'));

    // Test language change updates ApiService header
    await sl<AppRepository>().saveLanguage('hi');
    expect(apiService.headers['Accept-Language'], equals('hi'));
  });
}
