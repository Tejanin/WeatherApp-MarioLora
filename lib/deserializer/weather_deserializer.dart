class WeatherData {
  final double temperature;
  final int condition;
  final String cityName;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.cityName,
  });


  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'],
      condition: json['weather']['id'],
      cityName: json['name'],
    );
  }
}
