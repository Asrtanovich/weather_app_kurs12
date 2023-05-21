import 'dart:convert';
import 'dart:developer';
// import 'dart:math';

import 'package:http/http.dart' as http;

import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_kurs12/constants/api_keys/api_keys.dart';
import 'package:weather_app_kurs12/data/weather_data.dart';
import 'package:weather_app_kurs12/views/search_view.dart';

import '../datetime/date_tame.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String cityName = '';
  String tempreture = '';
  String icons = '';
  bool isLoading = false;
  String country = '';
  // String description = '';

  @override
  void initState() {
    showWeatherByLocation();
    super.initState();
  }

  Future<void> showWeatherByLocation() async {
    final position = await _getPosition();
    // log('latitude ===> ${position.latitude}');
    // log('longitude ===> ${position.longitude}');
    await getWeather(position);
  }

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
      tempreture = WeatherData.calculteWeather(kelvin);
      country = jsonJoop['sys']['country'];
      // description = WeatherData.getDescription(num.parse(tempreture));
      icons = WeatherData.getWeatherIcon(num.parse(tempreture));

      log('city name ===> ${jsonJoop['name']}');
      setState(() {
        isLoading = false;
      });
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
        // country = data['sys']['country'];
        final kelvin = data['main']['temp'];
        tempreture = WeatherData.calculteWeather(kelvin);
        // description = WeatherData.getDescription(num.parse(tempreture));
        icons = WeatherData.getWeatherIcon(num.parse(tempreture));
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
                Icons.search,
                size: 50,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cloud.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                )
              : Stack(
                  children: [
                    // Positioned(
                    //   top: 155,
                    //   left: 230,
                    //   // height: 106,
                    //   child: Text(
                    //     icons,
                    //     style: TextStyle(
                    //       fontSize: 50,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 170,
                    //   left: 100,
                    //   right: 100,
                    //   child: Text(
                    //     '$tempreture°',
                    //     style: TextStyle(
                    //       fontSize: 50,
                    //       color: Colors.white,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    Positioned(
                      top: 390,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 320,
                        decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 23, 23, 23).withOpacity(0.9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Понедельник',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '$tempreture',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Вторник',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 55,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'data',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Среда',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 77,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'data',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Четверг',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'data',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Пятница',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 55,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'data',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Суббота',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'data',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Воскресенье',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'data',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 90,
                    //   left: 30,
                    //   right: 30,
                    //   child: Text(
                    //     "📍${cityName}",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontSize: 30,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 180,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 180,
                        width: 130,
                        decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 23, 23, 23).withOpacity(0.9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 500,
                              child: Text(
                                "📍${cityName}",
                                // textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 500,
                              child: Text(
                                '$formattedDate',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 96, 90, 90),
                                  fontWeight: FontWeight.bold,
                                ),
                                // textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  icons,
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '$tempreture°',
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 30,
                      right: 30,
                      child: Text(
                        "Погода",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 47,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
