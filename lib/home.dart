import 'package:flutter/material.dart';
import 'package:one_device_auth/weather_service.dart';

import 'auth_service.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _checkDeviceAndFetchWeather();
  }

  void _checkDeviceAndFetchWeather() async {
    bool isAuthorized = await _authService.checkDeviceAuthorization();

    if (!isAuthorized) {
      await _authService.logout();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen())
      );
      return;
    }

    try {
      final weather = await _weatherService.fetchWeather();
      setState(() {
        _weatherData = weather;
      });
    } catch (e) {
      print('Weather fetch error: $e');
    }
  }

  void _logout() async {
    await _authService.logout();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: _weatherData == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Weather in London'),
            Text('Temperature: ${(_weatherData!['main']['temp'] - 273.15).toStringAsFixed(2)}°C'),
            Text('Description: ${_weatherData!['weather'][0]['description']}'),
          ],
        ),
      ),
    );
  }
}