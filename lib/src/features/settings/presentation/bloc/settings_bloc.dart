import 'package:expensive_tracker_app/common_exports.dart';

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
