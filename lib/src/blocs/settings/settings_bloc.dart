import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expensive_tracker_app/repositories/app_repository.dart';
import 'package:expensive_tracker_app/blocs/settings/settings_event.dart';
import 'package:expensive_tracker_app/blocs/settings/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AppRepository _repository;

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
