import 'package:expensive_tracker_app/utils/common_exports.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final AppRepository _repository;

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
