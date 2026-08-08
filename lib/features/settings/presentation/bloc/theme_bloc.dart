import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/settings_repository.dart';
import 'theme_event.dart';
import 'theme_state.dart';

/// 🔴 FEATURE-SCOPED BLoC
/// [ThemeBloc] manages theme state (Light/Dark/System) using [SettingsRepository].
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _repository;

  ThemeBloc(this._repository) : super(const ThemeState(ThemeMode.system)) {
    on<LoadTheme>((event, emit) {
      final mode = _repository.getTheme();
      emit(ThemeState(mode));
    });

    on<ThemeChanged>((event, emit) async {
      await _repository.saveTheme(event.themeMode);
      emit(ThemeState(event.themeMode));
    });
  }
}
