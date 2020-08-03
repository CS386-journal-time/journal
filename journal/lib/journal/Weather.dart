import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  String weatherReport = '';

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String _locality = '';
  String _weather = '';

  Future<Position> getPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<Placemark> getPlacemark(double latitude, double longitude) async {
    print('$latitude and $longitude');

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);

    return placemark[0];
  }

  Future<String> getData(double latitude, double longitude) async {
    //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}

    String api = 'https://api.openweathermap.org/data/2.5/weather';
    String appId = 'a4f91253e2d1e2e0f0e9f01143d6f2f2';

    String url = '$api?lat=$latitude&lon=$longitude&appid=$appId';

    http.Response response = await http.get(url);

    var parsed = json.decode(response.body);

    int highTemp = ConvertTemp(parsed['main']['temp_max']);
    int lowTemp = ConvertTemp(parsed['main']['temp_min']);

    var forecast = parsed['weather'][0]['description'];

    String out = '$forecast with a high of $highTemp and a low of $lowTemp';
    return out;
  }

  @override
  void initState() {
    super.initState();
    getPosition().then((position) {
      getPlacemark(position.latitude, position.longitude).then((data) {
        getData(position.latitude, position.longitude).then((weather) {
          _locality = data.locality;
          _weather = weather;
          setState(() {
            widget.weatherReport = 'Weather in $_locality, $_weather';
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Weather in $_locality, $_weather',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }

  int ConvertTemp(double temp) {
    return ((temp - 273.15) * 9 / 5 + 32).round();
  }
}
