
import 'package:my_projects/utils/common_exports.dart';

class Routes {
  static const String expenses = "/expenses";
  static const String initializeExpensiveTracker = "/initializeExpensiveTracker";
}

class NavigationServices {
  static final GlobalKey<NavigatorState> navigateKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigateKey.currentContext!;

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initializeExpensiveTracker:
        return MaterialPageRoute(
            builder: (_) => const InitializeExpensiveTrackerApp());
        case Routes.expenses:
        return MaterialPageRoute(
            builder: (_) => const Expenses());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route define ${settings.name}"),
            ),
          ),
        );
    }
  }
}
