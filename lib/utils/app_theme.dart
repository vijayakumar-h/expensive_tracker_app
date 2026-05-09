import 'package:flutter/cupertino.dart';
import 'common_exports.dart';

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class AppTheme {
  static const Color _white = Colors.white;
  static const Color _primary = Color.fromARGB(255, 96, 59, 181);
  static const Color _blackBG = Color(0XFF0E0E0F);
  static const Color _primaryColor = Color(0xFF9761FF);
  static const Color _mediumGrayBG = Color(0XFF969A9E);
  static const Color _lightGrayBG = Color(0XFFE5E4E6);
  static const Color _neutralColor = Color(0XFFF5F5F5);

  static const MaterialColor _mainAppColor =
      MaterialColor(0xFF000000, <int, Color>{
    50: Color(0xFF000000), 100: Color(0xFF000000), 200: Color(0xFF000000),
    300: Color(0xFF000000), 400: Color(0xFF000000), 500: Color(0xFF000000),
    600: Color(0xFF000000), 700: Color(0xFF000000), 800: Color(0xFF000000),
    900: Color(0xFF000000),
  });

  // THE KEY: A completely sanitized Typography root.
  static Typography get _safeTypography {
    final base = Typography.material2021();
    return Typography.material2021(
      black: _forceInherit(base.black),
      white: _forceInherit(base.white),
      englishLike: _forceInherit(base.englishLike),
      tall: _forceInherit(base.tall),
      dense: _forceInherit(base.dense),
    );
  }

  ThemeData get light {
    final theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      typography: _safeTypography,
      primarySwatch: _mainAppColor,
      scaffoldBackgroundColor: _white,
      fontFamily: "Poppins",
    );

    final customText = _forceInherit(const TextTheme(
      displayLarge: TextStyle(fontSize: 48, color: _blackBG, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 20, color: _blackBG, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 16, color: _blackBG, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(fontSize: 16, color: _blackBG, fontWeight: FontWeight.w400),
    ));

    return _applyCommonSanitization(theme.copyWith(
      textTheme: _forceInherit(theme.textTheme.merge(customText)),
      primaryTextTheme: _forceInherit(theme.primaryTextTheme.copyWith(
        bodyLarge: const TextStyle(color: _white),
        bodyMedium: const TextStyle(color: _white),
      )),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: _mainAppColor).copyWith(
        primary: _primary, onPrimary: _white, surface: _white, onSurface: _blackBG,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: _primary,
        selectedColor: _primary,
        titleTextStyle: const TextStyle(inherit: true, fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        subtitleTextStyle: const TextStyle(inherit: true, fontSize: 14, color: _mediumGrayBG, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        textColor: _primary, iconColor: _primary, collapsedIconColor: _blackBG, collapsedTextColor: _blackBG,
      ),
    ));
  }

  ThemeData get dark {
    final theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      typography: _safeTypography,
      scaffoldBackgroundColor: _blackBG,
      fontFamily: 'Poppins',
    );

    final customText = _forceInherit(const TextTheme(
      displayLarge: TextStyle(fontSize: 48, color: _white, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 20, color: _white, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 16, color: _white, fontWeight: FontWeight.w400),
      titleMedium: TextStyle(fontSize: 16, color: _white, fontWeight: FontWeight.w400),
    ));

    return _applyCommonSanitization(theme.copyWith(
      textTheme: _forceInherit(theme.textTheme.merge(customText)),
      primaryTextTheme: _forceInherit(theme.primaryTextTheme.merge(customText)),
      colorScheme: ColorScheme.fromSeed(seedColor: _primary, brightness: Brightness.dark),
      listTileTheme: ListTileThemeData(
        iconColor: _white,
        selectedColor: _primaryColor,
        titleTextStyle: const TextStyle(inherit: true, fontSize: 16, color: _white, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        textColor: _primaryColor, iconColor: _primaryColor, collapsedIconColor: _primaryColor, collapsedTextColor: _primaryColor,
      ),
    ));
  }

  static TextTheme _forceInherit(TextTheme theme) {
    TextStyle fix(TextStyle? s) => (s ?? const TextStyle()).copyWith(inherit: true);
    return TextTheme(
      displayLarge: fix(theme.displayLarge), displayMedium: fix(theme.displayMedium), displaySmall: fix(theme.displaySmall),
      headlineLarge: fix(theme.headlineLarge), headlineMedium: fix(theme.headlineMedium), headlineSmall: fix(theme.headlineSmall),
      titleLarge: fix(theme.titleLarge), titleMedium: fix(theme.titleMedium), titleSmall: fix(theme.titleSmall),
      bodyLarge: fix(theme.bodyLarge), bodyMedium: fix(theme.bodyMedium), bodySmall: fix(theme.bodySmall),
      labelLarge: fix(theme.labelLarge), labelMedium: fix(theme.labelMedium), labelSmall: fix(theme.labelSmall),
    );
  }

  ThemeData _applyCommonSanitization(ThemeData theme) {
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        titleTextStyle: (theme.appBarTheme.titleTextStyle ?? const TextStyle()).copyWith(inherit: true),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        labelStyle: (theme.inputDecorationTheme.labelStyle ?? const TextStyle()).copyWith(inherit: true),
        hintStyle: (theme.inputDecorationTheme.hintStyle ?? const TextStyle()).copyWith(inherit: true),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: (theme.iconButtonTheme.style ?? const ButtonStyle()).copyWith(
          textStyle: WidgetStatePropertyAll((theme.textTheme.labelLarge ?? const TextStyle()).copyWith(inherit: true)),
        ),
      ),
    );
  }

  CupertinoThemeData get lightCupertinoTheme => const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(textStyle: TextStyle(inherit: true, fontSize: 16, color: _blackBG)),
      );

  CupertinoThemeData get darkCupertinoTheme => const CupertinoThemeData(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(textStyle: TextStyle(inherit: true, fontSize: 16, color: _white)),
      );
}
