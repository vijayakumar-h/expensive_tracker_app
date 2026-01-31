import 'package:expensive_tracker_app/utils/common_exports.dart';

class AppController with AppMixin, HiveServices {
  factory AppController() => _singleton;
  static final AppController _singleton = AppController._internal();

  AppController._internal();

  set setAppTheme(ThemeMode themeMode) {
    appController.storeFromHive('themeValue', themeMode.name);
    appThemeModeNotifier.value = themeMode;
  }

  void setupInitialAppTheme() {
    final String themeModeName = appController.getFromHive('themeValue')?.toString() ??
        appThemeModeNotifier.value.name;
    final ThemeMode themeMode = ThemeMode.values
        .singleWhere((element) => element.name == themeModeName);
    setAppTheme = themeMode;
  }
}

mixin AppMixin {
  final ValueNotifier<ThemeMode> appThemeModeNotifier =
      ValueNotifier(ThemeMode.system);

}
