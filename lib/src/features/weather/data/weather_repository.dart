import 'package:expensive_tracker_app/src/features/weather/data/weather_model.dart';

class WeatherRepository {

  Future<WeatherModel> getWeather(String cityName) async {
// 1. Simulate network delay (1 second)
    await Future.delayed(const Duration(seconds: 1));

    // 2. Simple validation check
    if (cityName.trim().isEmpty) {
      throw Exception('City name cannot be empty');
    }

    // Simulate an error if the user types "error"
    if (cityName.toLowerCase() == 'error') {
      throw Exception('City not found on the weather server');
    }

    // 3. Return mock weather data wrapped cleanly in our WeatherModel
    return WeatherModel(
      cityName: _capitalize(cityName),
      temperature: 24.5,
      condition: 'Sunny',
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}