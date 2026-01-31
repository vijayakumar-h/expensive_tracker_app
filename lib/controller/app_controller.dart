import 'package:expensive_tracker_app/utils/common_exports.dart';

class AppController with AppMixin, HiveServices {
  factory AppController() => _singleton;
  static final AppController _singleton = AppController._internal();

  AppController._internal();
}

mixin AppMixin {
  final ValueNotifier<ThemeMode> appThemeModeNotifier =
      ValueNotifier(ThemeMode.system);
}
