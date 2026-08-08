import 'package:expensive_tracker_app/src/utils/common_exports.dart';
import 'package:expensive_tracker_app/src/features/auth/auth_wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);

  // =========================================================================
  // 🟢 SINGLETONS INITIALIZATION START HERE
  // [initServiceLocator] registers persistent singletons: ApiService, AppRepository & AuthRepository.
  // =========================================================================
  await initServiceLocator();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>.value(value: sl<AppRepository>()),
        RepositoryProvider<AuthRepository>.value(value: sl<AuthRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          // 🔴 FEATURE SCOPED BLoCs take over, consuming GetIt singletons
          BlocProvider(
            create: (context) => ThemeBloc(sl<AppRepository>())..add(LoadTheme()),
          ),
          BlocProvider(
            create: (context) => ExpenseBloc(sl<AppRepository>())..add(LoadExpenses()),
          ),
          BlocProvider(
            create: (context) => UserBloc(sl<AppRepository>())..add(LoadUser()),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(sl<AppRepository>())..add(LoadSettings()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(sl<AuthRepository>())..add(AppStarted()),
          ),
        ],
        child: const ExpensiveTrackerApp(),
      ),
    ),
  );
}

class ExpensiveTrackerApp extends StatelessWidget {
  const ExpensiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Expensive Tracker',
              debugShowCheckedModeBanner: false,
              themeMode: themeState.themeMode,
              theme: AppTheme().light,
              darkTheme: AppTheme().dark,
              locale: Locale(settingsState.languageCode),
              supportedLocales: const [
                Locale('en', ''),
                Locale('hi', ''),
                Locale('kn', ''),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const AuthWrapper(),
            );
          },
        );
      },
    );
  }
}
