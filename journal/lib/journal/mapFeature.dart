import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DayView.dart';
import 'package:geolocator/geolocator.dart';

class mapFeature extends StatefulWidget {
  final String selectDay;

  mapFeature({this.selectDay});

  @override
  _mapFeatureState createState() => _mapFeatureState();
}

class _mapFeatureState extends State<mapFeature> {
  var lat;
  var lon;

  Future<Position> getPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  void initState() {
    super.initState();
    getPosition().then((position) {
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getPosition();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectDay),
      ),
      body: new FlutterMap(
          options: new MapOptions(center: new LatLng(lat, lon), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => DayView(selectDay: widget.selectDay),
          );
          Navigator.push(context, route);
        },
        label: Text('To Journal'),
        icon: Icon(FontAwesomeIcons.journalWhills),
      ),
    );
  }
}
