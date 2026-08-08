import 'package:expensive_tracker_app/common_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);

  // Data Sources
  final expenseLocalDataSource =
      ExpenseLocalDataSourceImpl(hiveService: hiveService);
  final expenseRemoteDataSource =
      ExpenseRemoteDataSourceImpl(apiService: apiService);
  final settingsLocalDataSource =
      SettingsLocalDataSourceImpl(hiveService: hiveService);
  final userLocalDataSource = UserLocalDataSourceImpl(hiveService: hiveService);
  final authRemoteDataSource =
      MockAuthRemoteDataSourceImpl(apiService: apiService);

  // Repositories
  final expenseRepository = ExpenseRepositoryImpl(
    localDataSource: expenseLocalDataSource,
    remoteDataSource: expenseRemoteDataSource,
  );
  await expenseRepository.init();

  final settingsRepository = SettingsRepositoryImpl(
    localDataSource: settingsLocalDataSource,
    apiService: apiService,
  );

  final userRepository =
      UserRepositoryImpl(localDataSource: userLocalDataSource);
  final authRepository =
      AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExpenseRepository>.value(value: expenseRepository),
        RepositoryProvider<SettingsRepository>.value(value: settingsRepository),
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<AuthRepository>.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(context.read<SettingsRepository>())
              ..add(const LoadTheme()),
          ),
          BlocProvider(
            create: (context) => ExpenseBloc(context.read<ExpenseRepository>())
              ..add(const LoadExpenses()),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(context.read<UserRepository>())..add(LoadUser()),
          ),
          BlocProvider(
            create: (context) =>
                SettingsBloc(context.read<SettingsRepository>())
                  ..add(const LoadSettings()),
          ),
          BlocProvider(
            create: (context) =>
                AuthBloc(context.read<AuthRepository>())..add(AppStarted()),
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
