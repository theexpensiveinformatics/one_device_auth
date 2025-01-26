import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<Map<String, dynamic>> fetchWeather() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=London&appid=972f729b6d590bb65554b1d95eb30eca&units=metric')
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      print('Weather fetch error: $e');
      rethrow;
    }
  }
}