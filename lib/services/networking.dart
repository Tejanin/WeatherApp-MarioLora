import 'dart:convert';
import 'package:http/http.dart' as http;

import '../deserializer/weather_deserializer.dart';

class Networking {
  final String url;

  Networking({required this.url});

  Future<WeatherData> getData() async {
    // Hacer la solicitud HTTP GET
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, decodificamos el JSON
      var jsonResponse = jsonDecode(response.body);

      // Mapeamos el JSON a una instancia de WeatherData
      WeatherData weatherData = WeatherData.fromJson(jsonResponse);

      return weatherData;
    } else {
      // Si la solicitud falla, lanzamos una excepción
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
