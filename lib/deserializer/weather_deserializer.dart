class WeatherData {
  final int temperature;
  final int condition;
  final String cityName;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.cityName,
  });


  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'].toInt(),
      condition: json['weather'][0]['id'],
      cityName: json['name'],
    );
  }
}
