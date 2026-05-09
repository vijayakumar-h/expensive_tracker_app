import 'package:expensive_tracker_app/utils/common_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  final repository = AppRepository();
  await repository.init();
  
  runApp(
    RepositoryProvider.value(
      value: repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(repository)..add(LoadTheme()),
          ),
          BlocProvider(
            create: (context) => ExpenseBloc(repository)..add(LoadExpenses()),
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
          home: const InitializerApp(),
        );
      },
    );
  }
}
