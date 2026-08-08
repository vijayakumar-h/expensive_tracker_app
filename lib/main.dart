import 'common_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);

  await initServiceLocator();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExpenseRepository>.value(
            value: sl<ExpenseRepository>()),
        RepositoryProvider<SettingsRepository>.value(
            value: sl<SettingsRepository>()),
        RepositoryProvider<UserRepository>.value(value: sl<UserRepository>()),
        RepositoryProvider<AuthRepository>.value(value: sl<AuthRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ThemeBloc(sl<SettingsRepository>())..add(LoadTheme()),
          ),
          BlocProvider(
            create: (context) =>
                ExpenseBloc(sl<ExpenseRepository>())..add(LoadExpenses()),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(sl<UserRepository>())..add(LoadUser()),
          ),
          BlocProvider(
            create: (context) =>
                SettingsBloc(sl<SettingsRepository>())..add(LoadSettings()),
          ),
          BlocProvider(
            create: (context) =>
                AuthBloc(sl<AuthRepository>())..add(AppStarted()),
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
