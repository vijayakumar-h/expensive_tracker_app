import 'package:bloc/bloc.dart';
import 'package:expensive_tracker_app/src/features/weather/data/weather_model.dart';
import 'package:meta/meta.dart';

import '../data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      emit(state.copyWith(status: WeatherStatus.loading));
      try {

      }catch (e){
        emit(state.copyWith(
          status:WeatherStatus.failure,
          errorMessage: 'Could not find weather for "$event"',

        ));
      }
    });
  }
}
