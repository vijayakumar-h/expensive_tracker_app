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
    final String themeModeName =
        appController.getFromHive('themeValue')?.toString() ??
            appThemeModeNotifier.value.name;
    final ThemeMode themeMode = ThemeMode.values
        .singleWhere((element) => element.name == themeModeName);
    setAppTheme = themeMode;
  }

  Future<void> draggableBottomSheet({
    bool expand = false,
    double? minChildSize,
    double? maxChildSize,
    double? initialChildSize,
    bool isScrollControlled = true,
    required BuildContext context,
    DraggableScrollableController? draggableController,
    required Widget Function(BuildContext, ScrollController) builder,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
          borderSide: BorderSide(
            width: 0.0,
            style: BorderStyle.none,
            color: Colors.transparent,
          ),
        ),
        sheetAnimationStyle: AnimationStyle(
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
        ),
        builder: (BuildContext context) => DraggableScrollableSheet(
          builder: builder,
          expand: expand,
          controller: draggableController,
          minChildSize: minChildSize ?? 0.5,
          maxChildSize: maxChildSize ?? 0.80,
          initialChildSize: initialChildSize ?? 0.5,
        ),
      );
}

mixin AppMixin {
  final ValueNotifier<ThemeMode> appThemeModeNotifier =
      ValueNotifier(ThemeMode.system);
}
