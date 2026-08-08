import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// 🔴 FEATURE-SCOPED BLoC
/// [SettingsBloc] manages language and settings state using [SettingsRepository] interface.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc(this._repository) : super(const SettingsState()) {
    on<LoadSettings>((event, emit) {
      final languageCode = _repository.getLanguage();
      emit(SettingsState(languageCode: languageCode));
    });

    on<LanguageChanged>((event, emit) async {
      await _repository.saveLanguage(event.languageCode);
      emit(SettingsState(languageCode: event.languageCode));
    });
  }
}
