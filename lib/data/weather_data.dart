class WeatherData {
  calculteWeather(double kelvin) {
    final data = (kelvin - 273.15).toStringAsFixed(0);
    return data;
  }

  String getDescription(num temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'Сага шарф🧣 жана перчатки керек🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  String getWeatherIcon(num temp) {
    if (temp > 20 - 25) {
      return '☀️';
    } else if (temp > 10 - 20) {
      return '⛅';
    } else if (temp < 0 - 10) {
      return '🌧';
    } else if (temp < -20 - 0) {
      return '❄';
    } else {
      return '🤷';
    }
  }
}
