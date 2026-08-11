part of 'weather_bloc.dart';

enum WeatherStatus {initial, loading, success, failure}

class WeatherState {
  final String? errorMessage;
  final WeatherModel? weather;
  final WeatherStatus status;

  WeatherState({
    this.weather,
    this.errorMessage,
    this.status = WeatherStatus.initial,
  });

  WeatherState copyWith({
    String? errorMessage,
    WeatherModel? weather,
    WeatherStatus? status,
  }) {
    return WeatherState(
      weather: weather,
      errorMessage: errorMessage,
      status: WeatherStatus.initial,
    );
  }
}

final class WeatherInitial extends WeatherState {}
