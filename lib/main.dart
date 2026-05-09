import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:expensive_tracker_app/features/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  
  final appRepository = AppRepository();
  await appRepository.init();
  
  final authRepository = MockAuthRepository();
  
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>.value(value: appRepository),
        RepositoryProvider<AuthRepository>.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(appRepository)..add(LoadTheme()),
          ),
          BlocProvider(
            create: (context) => ExpenseBloc(appRepository)..add(LoadExpenses()),
          ),
          BlocProvider(
            create: (context) => UserBloc(appRepository)..add(LoadUser()),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(appRepository)..add(LoadSettings()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(authRepository)..add(AppStarted()),
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: AppTheme().light,
          darkTheme: AppTheme().dark,
          home: const AuthWrapper(),
        );
      },
    );
  }
}
