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
  final _weather = WeatherModel();

  int _temperature;
  String _weatherDescription;
  String _weatherIcon;
  String _cityName;

  @override
  void initState() {
    super.initState();

    _updateUi(widget.locationWeather);
  }

  void _updateUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        _temperature = 0;
        _weatherIcon = 'Error';
        _weatherDescription = 'no data';
        _cityName = '';
        return;
      }
      final _temp = weatherData['main']['temp'];
      _temperature = _temp.toInt();
      _weatherDescription = _temperature.toString();
      _weatherDescription = _weather.getMessage(_temperature);

      _cityName = weatherData['name'];

      final condition = weatherData['weather'][0]['id'];
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
                    onPressed: () async => _updateUi(
                      await _weather.locationWeather,
                    ),
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CityScreen(),
                        ),
                      );
                      if (typedName != null) {
                        _updateUi(await _weather.getCityWeather(typedName));
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
