part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;

  FetchWeatherEvent(this.cityName);
}

class WeatherUser extends WeatherEvent {}
