import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _cityController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  String? _cityName;
  double? _temperature;
  double? _windSpeed;
  int? _weatherCode;

  // Weather code ko readable text/icon mein convert karna
  String _getWeatherDescription(int code) {
    if (code == 0) return 'Clear Sky';
    if (code <= 3) return 'Partly Cloudy';
    if (code <= 48) return 'Foggy';
    if (code <= 57) return 'Drizzle';
    if (code <= 67) return 'Rainy';
    if (code <= 77) return 'Snowy';
    if (code <= 82) return 'Rain Showers';
    if (code <= 99) return 'Thunderstorm';
    return 'Unknown';
  }

  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny;
    if (code <= 3) return Icons.cloud;
    if (code <= 48) return Icons.foggy;
    if (code <= 67) return Icons.grain;
    if (code <= 77) return Icons.ac_unit;
    if (code <= 99) return Icons.thunderstorm;
    return Icons.wb_cloudy;
  }


  Future<void> _getWeather() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {

      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1',
      );
      final geoResponse = await http.get(geoUrl);
      final geoData = jsonDecode(geoResponse.body);

      if (geoData['results'] == null || geoData['results'].isEmpty) {
        setState(() {
          _errorMessage = 'City nahi mila. Naam check karein.';
          _isLoading = false;
        });
        return;
      }

      final lat = geoData['results'][0]['latitude'];
      final lon = geoData['results'][0]['longitude'];
      final name = geoData['results'][0]['name'];


      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
      );
      final weatherResponse = await http.get(weatherUrl);
      final weatherData = jsonDecode(weatherResponse.body);

      final current = weatherData['current_weather'];

      setState(() {
        _cityName = name;
        _temperature = current['temperature'].toDouble();
        _windSpeed = current['windspeed'].toDouble();
        _weatherCode = current['weathercode'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Kuch ghalat hua. Internet check karein.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City ka naam likhein (e.g. Lahore)',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _getWeather,
                ),
              ),
              onSubmitted: (_) => _getWeather(),
            ),
            const SizedBox(height: 20),

            if (_isLoading) const CircularProgressIndicator(),

            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),

            if (_temperature != null && !_isLoading) ...[
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        _cityName ?? '',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Icon(
                        _getWeatherIcon(_weatherCode ?? 0),
                        size: 60,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_temperature!.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _getWeatherDescription(_weatherCode ?? 0),
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Text('Wind Speed: ${_windSpeed!.toStringAsFixed(1)} km/h'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}