import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:journal/JournalEntry.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

File _imageFile;
int _counter = 0;

ScreenshotController screenshotController = ScreenshotController();

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
                  children: <Widget>[
                    Screenshot(
                      controller: screenshotController,
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () {
                          print('Marker tapped');
                        },
                      ),
                    ),
                    _imageFile != null ? Image.file(_imageFile) : Container(),
                  ],


                ),
              ),
            ]),
          ]),

     //Temporarily commenting out to use screenshotting floatingActionButton

     /* floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => JournalEntry(selectDay: widget.selectDay),
          );
          Navigator.push(context, route);
        },
        label: Text('Save'),
        icon: Icon(FontAwesomeIcons.save),
        backgroundColor: Colors.green[900],
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _imageFile = null;
          screenshotController
              .capture()
              .then((File image) async {
            setState(() {
              _imageFile = image;
            });
            final result = await ImageGallerySaver.save(image.readAsBytesSync());
            print("Location Saved to Gallery");
          }).catchError((onError) {
            print(onError);
          });
        },
        tooltip: 'Inc',
        child: Icon(Icons.add),
      ),

    final directory = (await getApplicationDocumentsDirectory ()).path;
    String fileName = DateTime.now().toIso8601String();
    path = '$directory/$fileName.png';

    screenshotController.capture(
    path:path //set path where screenshot will be saved
    );
    );
  }




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


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Container(
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:' +
                        _counter.toString(),
                  ),
                  FlutterLogo(),
                ],
              ),
            ),
            _imageFile != null ? Image.file(_imageFile) : Container(),
          ],
        ),
      ),
    ),
 // This trailing comma makes auto-formatting nicer for build methods.
  );
}
