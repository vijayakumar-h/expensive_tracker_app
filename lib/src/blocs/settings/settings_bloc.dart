import 'package:expensive_tracker_app/src/utils/common_exports.dart';

/// 🔴 SHORT-LIVED FEATURE BLoC
/// [SettingsBloc] manages language and settings state for the application.
/// It receives [AppRepository] via constructor injection (supplied by GetIt `sl<AppRepository>()`).
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
