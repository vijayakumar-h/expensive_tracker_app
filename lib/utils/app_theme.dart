import 'package:flutter/cupertino.dart';

import 'common_exports.dart';

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class AppTheme {
  static const Color _white = Colors.white;
  static const Color _primary = Color.fromARGB(255, 96, 59, 181);
  static const Color success = Color(0xFF43a017);
  static const Color _blackBG = Color(0XFF0E0E0F);
  static const Color _secondaryColor = _primaryColor;
  static const Color _errorColor = Color(0XFFCC2708);
  static const Color _lightGrayBG = Color(0XFFE5E4E6);
  static const Color _darkGreyBG = Color(0xFF2D2C2F);
  static const Color _primaryColor = Color(0xFF9761FF);
  static const Color mediumColor = Color(0XFFCAAEFF);
  static const Color _lightColor = Color(0XFFEBE6CA);
  static const Color _mediumGrayBG = Color(0XFF969A9E);
  static const Color _neutralColor = Color(0XFFF5F5F5);

  static const MaterialColor _mainAppColor =
      MaterialColor(0xFF000000, <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  });

  ThemeData get light => ThemeData(
        hintColor: _primary,
        hoverColor: _primary,
        shadowColor: _primary,
        primaryColor: _primary,
        indicatorColor: _primary,
        primarySwatch: _mainAppColor,
        scaffoldBackgroundColor: _white,
        primaryColorDark: _mainAppColor,
        primaryColorLight: _mainAppColor,
        canvasColor: _white,
        // _white.withOpacity(0.8),
        tooltipTheme: const TooltipThemeData(
            showDuration: Duration(seconds: 2),
            triggerMode: TooltipTriggerMode.tap,
            textStyle: TextStyle(color: _primary),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: EdgeInsets.all(8)),
        dialogTheme: DialogThemeData(backgroundColor: _white.withOpacity(0.8)),
        fontFamily: "Poppins",
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: _white),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 48,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          displayMedium: TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          displaySmall: TextStyle(
              fontSize: 32,
              fontStyle: FontStyle.normal,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          titleLarge: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            color: _primary,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          titleSmall: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          labelLarge: TextStyle(
            fontSize: 16,
            color: _primary,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: _primary,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: _primary,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: _primary,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: const IconThemeData(color: _mainAppColor),
        cardTheme: CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: _primary.withOpacity(0.04),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            side: BorderSide(width: 0.5, color: _primary),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0x00ffffff), primarySwatch: _mainAppColor),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: _primary),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStatePropertyAll(_primary.withOpacity(0.5)),
        ),
        checkboxTheme: CheckboxThemeData(
          side: const BorderSide(color: _primary),
          checkColor: const WidgetStatePropertyAll(_white),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (!states.contains(WidgetState.selected)) {
              return Colors.transparent;
            }
            return _primary;
          }),
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: _primary,
          dividerColor: _primary,
          indicatorColor: _primary,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: _primary.withOpacity(0.2),
          labelPadding: EdgeInsets.zero,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          applyThemeToAll: true,
          primaryColor: _primary,
          scaffoldBackgroundColor: _white,
          textTheme: CupertinoTextThemeData(
            primaryColor: _primary,
            textStyle: TextStyle(fontFamily: "Poppins", color: _primary),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: _primary,
          selectionColor: _primary.withOpacity(0.35),
          selectionHandleColor: _primary.withOpacity(0.1),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(_primary),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(_primary.withOpacity(0.04)),
            foregroundColor: const WidgetStatePropertyAll(_primary),
            side: const WidgetStatePropertyAll(
              BorderSide(color: _primary),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          isDense: true,
          fillColor: _white,
          iconColor: _primary,
          suffixIconColor: _primary,
          prefixIconColor: _primary,
          labelStyle: TextStyle(
            fontSize: 16,
            color: _primary,
            fontWeight: FontWeight.w400,
          ),
          prefixStyle: TextStyle(
            fontSize: 13,
            color: _primary,
            fontWeight: FontWeight.w400,
          ),
          suffixStyle: TextStyle(
            fontSize: 14,
            color: _primary,
            fontWeight: FontWeight.w400,
          ),
          errorStyle: TextStyle(
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            fontSize: 16,
            // color: AppColors.mediumGray,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: _primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            // borderSide: BorderSide(width: 1, color: AppColors.mediumGray),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: _primary),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            // borderSide: BorderSide(width: 1, color: AppColors.vividRed),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            // borderSide: BorderSide(width: 1, color: AppColors.vividRed),
          ),
        ),
        chipTheme: const ChipThemeData(
          deleteIconColor: _primary,
          // backgroundColor: AppColors.whiteSmoke,
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            color: _primary,
            fontWeight: FontWeight.w400,
          ),
        ),
        dividerTheme:
            DividerThemeData(thickness: 0.5, color: _primary.withOpacity(0.8)),
        snackBarTheme: const SnackBarThemeData(
          elevation: 5,
          // backgroundColor: AppColors.saltPan,
          contentTextStyle: TextStyle(
            fontSize: 16,
            color: _primary,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          backgroundColor: _white,
          foregroundColor: _primary,
          iconTheme: IconThemeData(color: _primary),
          titleTextStyle: TextStyle(
            fontSize: 34,
            color: _primary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 2,
          foregroundColor: _white,
          backgroundColor: _primary,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          textColor: _primary,
          iconColor: _primary,
          collapsedIconColor: _primary,
          collapsedTextColor: _primary,
          childrenPadding: EdgeInsets.only(left: 20),
        ),
      );

  ThemeData get dark => ThemeData(
        focusColor: _white,
        fontFamily: 'Poppins',
        canvasColor: _blackBG,
        hoverColor: Colors.red,
        primaryColorDark: _white,
        brightness: Brightness.dark,
        primaryColor: _primaryColor,
        dividerColor: _primaryColor,
        disabledColor: _lightGrayBG,
        // primarySwatch: _primarySwatchLight,
        scaffoldBackgroundColor: _blackBG,
        cardColor: const Color(0xff1A1A1A),
        secondaryHeaderColor: _secondaryColor,
        unselectedWidgetColor: _secondaryColor,
        cupertinoOverrideTheme: darkCupertinoTheme,
        splashColor: _primaryColor.withOpacity(0.1),
        actionIconTheme: const ActionIconThemeData(),
        highlightColor: _primaryColor.withOpacity(0.1),
        iconTheme: const IconThemeData(color: _white),
        drawerTheme: const DrawerThemeData(
          elevation: 0,
          backgroundColor: _blackBG,
        ),
        tooltipTheme: const TooltipThemeData(
          showDuration: Duration(seconds: 2),
          textStyle: TextStyle(color: _white),
          triggerMode: TooltipTriggerMode.tap,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          padding: EdgeInsets.all(8),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(),
        ),
        primaryColorLight: _primaryColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 48,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          displayMedium: TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          displaySmall: TextStyle(
              fontSize: 32,
              fontStyle: FontStyle.normal,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600),
          titleLarge: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            color: _white,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          titleSmall: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          labelLarge: TextStyle(
            fontSize: 16,
            color: _white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: _white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: _white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: _white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: _blackBG,
          selectedItemColor: _primaryColor,
          unselectedItemColor: _white,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: _mediumGrayBG,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: _white,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
        listTileTheme: ListTileThemeData(
          iconColor: _white,
          selectedColor: _primaryColor,
          selectedTileColor: _primaryColor.withOpacity(0.1),
          titleTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          foregroundColor: _blackBG,
          backgroundColor: _blackBG,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            fontSize: 34,
            color: _white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(_blackBG),
          checkColor: WidgetStateProperty.all(_secondaryColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (_) => const BorderSide(
              width: 1.5,
              color: _secondaryColor,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _blackBG,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: _white,
            fontWeight: FontWeight.w400,
          ),
          errorStyle: const TextStyle(
            fontSize: 13,
            // color: _errorColor,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            fontSize: 16,
            color: _mediumGrayBG,
            fontFamily: 'Poppins',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: _white),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: _white, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: _primaryColor.withOpacity(0.06),
          shape: const ContinuousRectangleBorder(
            side: BorderSide(width: 0, color: _primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        dividerTheme: DividerThemeData(
            thickness: 0.5, color: _primaryColor.withOpacity(0.4)),
        tabBarTheme: TabBarThemeData(
          labelColor: _primary,
          dividerColor: _primary,
          indicatorColor: _primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: _primary.withOpacity(0.2),
          labelPadding: EdgeInsets.zero,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
      );

  CupertinoThemeData get lightCupertinoTheme => const CupertinoThemeData(
        applyThemeToAll: true,
        primaryColor: _primaryColor,
        brightness: Brightness.light,
        scaffoldBackgroundColor: _white,
        barBackgroundColor: _neutralColor,
        primaryContrastingColor: _primaryColor,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 16,
            color: _blackBG,
          ),
        ),
      );

  CupertinoThemeData get darkCupertinoTheme => const CupertinoThemeData(
        applyThemeToAll: true,
        primaryColor: _primaryColor,
        brightness: Brightness.dark,
        barBackgroundColor: _blackBG,
        scaffoldBackgroundColor: _blackBG,
        primaryContrastingColor: _primaryColor,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 16,
            color: _white,
          ),
        ),
      );
}
