import 'package:get_it/get_it.dart';
import 'api_service.dart';
import '../repositories/app_repository.dart';
import '../repositories/auth_repository.dart';

/// Global [GetIt] Service Locator instance
final sl = GetIt.instance;

/// Initializes GetIt Service Locator Dependency Injection container
Future<void> initServiceLocator() async {
  // =========================================================================
  // 🟢 SINGLETONS START HERE (Data / Network Layer)
  // Singletons persist across the entire lifespan of the application.
  // =========================================================================

  // 1. ApiService Singleton (HTTP requests & dynamic Accept-Language header management)
  sl.registerLazySingleton<ApiService>(() => ApiService());

  // 2. AppRepository Singleton (Expense, Category, User Profile, Theme & Local Storage management)
  sl.registerLazySingleton<AppRepository>(
    () => AppRepository(apiService: sl<ApiService>()),
  );

  // 3. AuthRepository Singleton (Authentication handling)
  sl.registerLazySingleton<AuthRepository>(
    () => MockAuthRepository(apiService: sl<ApiService>()),
  );

  // Initialize AppRepository local storage (Hive)
  await sl<AppRepository>().init();

  // =========================================================================
  // 🔴 FEATURE SCOPE (BLoCs / Cubits)
  // Feature-scoped BLoCs (ThemeBloc, ExpenseBloc, UserBloc, SettingsBloc, AuthBloc)
  // receive GetIt singletons via constructor injection: `sl<AppRepository>()`
  // =========================================================================
}
