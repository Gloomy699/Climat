import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=754b78a5a28d1763483c0f1ae44f0569'));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(

        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       getLocation();
        //     },
        //     child: Text('Get Location'),
        //   ),
        // ),
        );
  }
}
