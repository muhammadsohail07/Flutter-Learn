import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {


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