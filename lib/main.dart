import 'package:flutter/material.dart';
import 'package:weather_app_kurs12/views/home_view.dart';
import 'package:weather_app_kurs12/views/search_view.dart';
import 'package:weather_app_kurs12/views/test_future.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
