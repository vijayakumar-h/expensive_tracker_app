import 'package:expensive_tracker_app/common_exports.dart';

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
