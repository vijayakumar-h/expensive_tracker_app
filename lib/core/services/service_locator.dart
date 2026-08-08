import 'package:get_it/get_it.dart';
import '../network/api_service.dart';
import 'hive_service.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

import '../../features/expenses/data/datasources/expense_local_datasource.dart';
import '../../features/expenses/data/datasources/expense_remote_datasource.dart';
import '../../features/expenses/data/repositories/expense_repository_impl.dart';
import '../../features/expenses/domain/repositories/expense_repository.dart';

import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';

import '../../features/user/data/datasources/user_local_datasource.dart';
import '../../features/user/data/repositories/user_repository_impl.dart';
import '../../features/user/domain/repositories/user_repository.dart';

/// Global [GetIt] Service Locator instance
final sl = GetIt.instance;

/// Initializes GetIt Service Locator Dependency Injection container
Future<void> initServiceLocator() async {
  // =========================================================================
  // 🟢 CORE SINGLETONS (Network & Persistence Services)
  // =========================================================================
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<HiveService>(() => HiveService());

  // =========================================================================
  // 🟢 DATA SOURCES
  // =========================================================================
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(hiveService: sl<HiveService>()),
  );
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(hiveService: sl<HiveService>()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(hiveService: sl<HiveService>()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => MockAuthRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // =========================================================================
  // 🟢 DOMAIN REPOSITORIES (Bound to Abstract Interfaces)
  // =========================================================================
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(
      localDataSource: sl<ExpenseLocalDataSource>(),
      remoteDataSource: sl<ExpenseRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: sl<SettingsLocalDataSource>(),
      apiService: sl<ApiService>(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl<UserLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  // Initialize Expense Local DataSource (Hive Storage)
  await sl<ExpenseRepository>().init();
}
