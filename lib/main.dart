


import 'package:expensive_tracker_app/utils/common_exports.dart';

void main() {
  runApp(const ExpensiveTrackerApp());
}

class ExpensiveTrackerApp extends StatelessWidget {
  const ExpensiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initializeExpensiveTracker,
      navigatorKey: NavigationServices.navigateKey,
      onGenerateRoute: NavigationServices().generateRoute,
    );
  }
}
