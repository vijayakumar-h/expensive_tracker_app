class WeatherModel {
  final String cityName;
  final String condition;
  final double temperature;

  WeatherModel({
    required this.cityName,
    required this.condition,
    required this.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['cityName'],
        condition: json['condition'],
        temperature: json['temperature'],
      );

  Map<String, dynamic> toJson() => {
        'cityName': cityName,
        'condition': condition,
        'temperature': temperature,
      };
}
