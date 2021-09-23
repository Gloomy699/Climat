import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const API_KEY = '754b78a5a28d1763483c0f1ae44f0569';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$API_KEY&units=metric');

    var weatherData = await networkHelper.data;
    return weatherData;
  }

  Future<dynamic> get locationWeather async {
    Location location = Location();
    await location.currentLocation;

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=metric');

    var weatherData = await networkHelper.data;
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp >= 25) {
      return 'тепло и кайфово на столько что можно и 🍦 скушать=)';
      // return 'It\'s 🍦 time';
    } else if (temp >= 20) {
      return 'не то что бы очень жарко но можно одеть шорты и 👕';
      // return 'Time for shorts and 👕';
    } else if (temp <= 0) {
      return 'холодина нереальная, лучше не выходи, если нужно выйти одень шубу';
    } else if (temp <= 10) {
      return 'охренеть как холодно и мерзко нужен 🧣 и 🧤';
      // return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'возьми пальто на всякий случай';
    }
  }
}
