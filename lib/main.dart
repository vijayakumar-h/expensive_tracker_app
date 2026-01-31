import 'package:expensive_tracker_app/utils/common_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  await appController.initializeHive();
  runApp(const ExpensiveTrackerApp());
}

class ExpensiveTrackerApp extends StatelessWidget {
  const ExpensiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appController.appThemeModeNotifier,
      builder: (context, themeMode, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: AppTheme().light,
        darkTheme: AppTheme().dark,
        home: const InitializeExpensiveTrackerApp(),
      ),
    );
  }
}
