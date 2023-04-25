import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_kurs12/constants/api_keys/api_keys.dart';
import 'package:weather_app_kurs12/views/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

dynamic getDescription(dynamic _temp) {
  if (_temp > 25) {
    return 'Bugun issik eken';
  } else if (_temp > 20) {
    return 'Salkin bolot';
  } else if (_temp < 10) {
    return 'Suuk bolot eken 🧣 🧤';
  } else {
    return 'Jiluu kiinip al';
  }
}

class _HomeViewState extends State<HomeView> {
  String cityName = '';
  dynamic tempreture = '';
  bool isLoading = false;
  String country = '';
  dynamic description;
  @override
  void initState() {
    showWeatherByLocation();
    super.initState();
  }

  // double checkDouble(dynamic value) {
  //   if (value is String) {
  //     return double.parse(value);
  //   } else {
  //     return value;
  //   }
  // }

  Future<void> showWeatherByLocation() async {
    final position = await _getPosition();
    await getWeather(position);

    // log('latitude ==> ${position.latitude}');
    // log('longitude ==> ${position.longitude}');
  }

  // CRUD
  // Create - post
  // Read - get
  // Update - put
  // Delete - delete
  Future<void> getWeather(Position position) async {
    setState(() {
      isLoading = true;
    });
    try {
      final client = http.Client();
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${ApiKeys.myApiKey}';
      Uri uri = Uri.parse(url);
      final joop = await client.get(uri);
      final jsonJoop = jsonDecode(joop.body);
      cityName = jsonJoop['name'];
      final double kelvin = jsonJoop['main']['temp'];
      tempreture = (kelvin - 273.15).toStringAsFixed(0);
      description = getDescription(tempreture);

      // checkDouble(tempreture = jsonJoop['main']['temp']);
      log('city name ===> ${jsonJoop['name']}');
      setState(() {
        isLoading = false;
      });

      // log('  response ==>  ${joop.body}');
      // log('  response json ==>  ${jsonJoop}');
    } catch (e) {
      log('$e');
      throw Exception(e);
    }
  }

  Future<void> getSearchedCityName(String typedCityName) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$typedCityName&appid=${ApiKeys.myApiKey}');
      final response = await client.get(uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('data ===> ${response.body}');
        final data = jsonDecode(response.body);
        log('data ===> ${data}');
        cityName = data['name'];
        country = data['sys']['country'];
        final double kelvin = data['main']['temp'];
        tempreture = (kelvin - 273.15).toStringAsFixed(0);
        setState(() {});
      }
    } catch (e) {}
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () async {
              await showWeatherByLocation();
            },
            child: Icon(
              Icons.near_me,
              size: 50,
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                final String typedCityName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchView(),
                  ),
                );
                await getSearchedCityName(typedCityName);
                setState(() {});
              },
              child: Icon(
                Icons.location_city,
                size: 50,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.green,
                  ),
                )
              : Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: 140,
                      child: Text(
                        '⛅',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 40,
                      child: Text(
                        '$tempreture\u2103',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 40,
                      child: Text(
                        'Country: $country ',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 280,
                      left: 0,
                      right: 50,
                      child: Text(
                        description ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 320,
                      // left: ,
                      right: 0,
                      child: Text(
                        '👚',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 500,
                      left: 30,
                      // right: 0,
                      child: Text(
                        cityName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
