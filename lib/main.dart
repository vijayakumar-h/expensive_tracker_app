import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/auth_wrapper.dart';
import 'features/expenses/domain/repositories/expense_repository.dart';
import 'features/expenses/presentation/bloc/expense_bloc.dart';
import 'features/expenses/presentation/bloc/expense_event.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'features/settings/presentation/bloc/theme_bloc.dart';
import 'features/settings/presentation/bloc/theme_event.dart';
import 'features/settings/presentation/bloc/theme_state.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/bloc/user_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);

  // Initialize Feature-First Clean Architecture GetIt singletons
  await initServiceLocator();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExpenseRepository>.value(value: sl<ExpenseRepository>()),
        RepositoryProvider<SettingsRepository>.value(value: sl<SettingsRepository>()),
        RepositoryProvider<UserRepository>.value(value: sl<UserRepository>()),
        RepositoryProvider<AuthRepository>.value(value: sl<AuthRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(sl<SettingsRepository>())..add(LoadTheme()),
          ),
          BlocProvider(
            create: (context) => ExpenseBloc(sl<ExpenseRepository>())..add(LoadExpenses()),
          ),
          BlocProvider(
            create: (context) => UserBloc(sl<UserRepository>())..add(LoadUser()),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(sl<SettingsRepository>())..add(LoadSettings()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(sl<AuthRepository>())..add(AppStarted()),
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
