class WeatherData {
  static calculteWeather(double kelvin) {
    final data = (kelvin - 273.15).toStringAsFixed(0);
    return data;
  }

  static String getWeatherIcon(num temp) {
    if (temp > 20 ||
        temp > 19 ||
        temp > 18 ||
        temp > 17 ||
        temp > 16 ||
        temp > 15 ||
        temp > 14 ||
        temp > 13 ||
        temp > 12 ||
        temp > 11 ||
        temp > 10) {
      return '☀️';
    } else if (temp >= 10 ||
        temp >= 9 ||
        temp >= 8 ||
        temp >= 7 ||
        temp >= 6 ||
        temp >= 5 ||
        temp >= 4 ||
        temp >= 3 ||
        temp >= 2 ||
        temp >= 1 ||
        temp >= 0) {
      return '⛅';
    } else if (temp < 0 - 10 ||
        temp < -1 ||
        temp < -2 ||
        temp < -3 ||
        temp < -4 ||
        temp < -5 ||
        temp < -6 ||
        temp < -7 ||
        temp < -8 ||
        temp < -9 ||
        temp < -10) {
      return '🌧';
    } else if (temp < 20 || temp < 10) {
      return '☔️';
    } else {
      return '🤷';
    }
  }
}
