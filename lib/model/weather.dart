// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:climate/model/network_helper.dart';

class Weather {
  final double weather;
  final String cityName;

  Weather({
    required this.weather,
    required this.cityName,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    return Weather(
      weather: json['main']['temp'],
      cityName: json['name'],
    );
  }

  static const apiKey = 'd72634f7ce99b88b9d7c1cce0152f605';

  static Future<Weather> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric';

    NetworkHelper helper = NetworkHelper(url: baseUrl);

    final response = await helper.getWeather();
    final json = jsonDecode(response);
    return Weather.fromJson(json);
  }

  static Future<Weather> getCityWeather({
    required String cityName,
  }) async {
    final baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey}&units=metric';

    NetworkHelper helper = NetworkHelper(url: baseUrl);

    final response = await helper.getWeather();
    final json = jsonDecode(response);
    return Weather.fromJson(json);
  }
}
