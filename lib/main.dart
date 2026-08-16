import 'package:expensive_tracker_app/common_exports.dart';
import 'package:expensive_tracker_app/src/features/tasks/bloc/task_bloc.dart';
import 'package:expensive_tracker_app/src/features/tasks/bloc/task_event.dart';
import 'package:expensive_tracker_app/src/features/tasks/data/task_repository.dart';
import 'package:expensive_tracker_app/src/features/tasks/presentation/task_screen.dart';
import 'package:expensive_tracker_app/src/features/weather/bloc/weather_bloc.dart';
import 'package:expensive_tracker_app/src/features/weather/data/weather_repository.dart';
import 'package:expensive_tracker_app/src/features/weather/presentation/weather_screen.dart';

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
          BlocProvider(
              create: (context) =>
                  WeatherBloc(context.read<WeatherRepository>())
                    ..add(WeatherUser())),
          // BlocProvider(
          //     create: (context) => TaskBloc(context.read<TaskRepository>())
          //       ..add(LoadTaskEvent())),
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
              home: const TaskScreen(),
            );
          },
        );
      },
    );
  }
}
