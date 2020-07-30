import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'JournalEntry.dart';
import 'package:latlong/latlong.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class mapFeature extends StatefulWidget {
  final String selectDay;

  mapFeature({this.selectDay});

  @override
  _mapFeatureState createState() => _mapFeatureState();
}

class _mapFeatureState extends State<mapFeature> {
  static File _map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectDay),
      ),
      body: new FlutterMap(
          options: new MapOptions(
              center: new LatLng(35.198, -111.651), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(markers: [
              new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(35.198, -111.651),
                builder: (context) => new Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 45.0,
                    onPressed: () {
                      print('Marker tapped');
                    },
                  ),
                ),
              ),
            ]),
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => JournalEntry(selectDay: widget.selectDay),
          );
          Navigator.push(context, route);
        },
        label: Text('Save'),
        icon: Icon(FontAwesomeIcons.save),
        backgroundColor: Colors.green[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

//

  Widget mapCard(File localImage) {
    return Container(
      width: 240.0,
      child: GestureDetector(
        //onTap: showAlertDialog,
        child: Container(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.grey[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text('A file in the future'),
          ),
        ),
      ),
    );
  }
}
