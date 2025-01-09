import 'package:weatherapp/deserializer/weather_deserializer.dart';
import 'package:weatherapp/models/weather_message.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';

class WeatherModel {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';
  final String apiKey = '08ec4d98ed6bb83822b5f88d7da07546';

  Future<WeatherMessage> getWeatherDataByCity(String cityName) async {
    try {
      Networking networking = Networking(url: '$baseUrl?q=$cityName&appid=$apiKey&units=metric');
      var weatherData = await networking.getData();

      if (weatherData == null) {
        throw Exception("No data received from API.");
      }

      WeatherData response = WeatherData.fromJson(weatherData);
      var weatherMessage = WeatherMessage(
        message: getMessage(response.temperature.toInt()),
        icon: getWeatherIcon(response.condition),
        temperature: (response.temperature.toInt()).toString(),
        city: response.cityName,
      );

      return weatherMessage;
    } catch (e) {
      print('Error fetching weather data by city: $e');
      // Manejo de error: puedes retornar un mensaje de error o un valor predeterminado
      return WeatherMessage(
        message: 'Error fetching weather data',
        icon: '🤷‍',
        temperature: '--',
        city: cityName,
      );
    }
  }

  Future<WeatherMessage> getWeatherData() async {
    try {
      Location location = Location();
      await location.getCurrentPosition();

      Networking networking = Networking(
          url:
          '${baseUrl}lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
      var weatherData = await networking.getData();

      if (weatherData == null) {
        print(weatherData);
        throw Exception("No data received from API.");
      }

      WeatherData response = WeatherData.fromJson(weatherData);
      var weatherMessage = WeatherMessage(
        message: getMessage(response.temperature.toInt()),
        icon: getWeatherIcon(response.condition),
        temperature: (response.temperature.toInt()).toString(),
        city: response.cityName,
      );

      return weatherMessage;
    } catch (e) {
      print('Error fetching weather data: $e');

      return WeatherMessage(
        message: 'Error fetching weather data',
        icon: '🤷‍',
        temperature: '--',
        city: 'Unknown',
      );
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

