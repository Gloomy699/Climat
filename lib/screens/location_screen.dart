import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({
    @required this.locationWeather,
  });

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel _weather = WeatherModel();

  int _temperature;
  String _weatherDescription;
  String _weatherIcon;
  String _cityName;

  @override
  void initState() {
    super.initState();

    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic _weatherData) {
    setState(() {
      if (_weatherData == null) {
        _temperature = 0;
        _weatherIcon = 'Error';
        _weatherDescription = 'no data';
        _cityName = '';
        return;
      }
      double _temp = _weatherData['main']['temp'];
      _temperature = _temp.toInt();
      _weatherDescription = _temperature.toString();
      _weatherDescription = _weather.getMessage(_temperature);

      _cityName = _weatherData['name'];

      var condition = _weatherData['weather'][0]['id'];
      _weatherIcon = _weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/location_background.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await _weather.locationWeather;
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var wetherData =
                            await _weather.getCityWeather(typedName);
                        updateUi(wetherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: tempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: conditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'в городе $_cityName $_weatherDescription',
                  textAlign: TextAlign.left,
                  style: messageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
