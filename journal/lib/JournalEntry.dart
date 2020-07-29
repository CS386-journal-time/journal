import 'package:flutter/material.dart';
import 'DayView.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Photo.dart';
import 'package:image_save/image_save.dart';
import 'package:journal/Journal.dart';
import 'package:journal/mapFeature.dart';

class JournalEntry extends StatelessWidget {
  final String selectDay;

  JournalEntry({this.selectDay});

  // scrollable image container
  Widget imageList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      height: 160,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Photo(),
          Photo(),
          Photo(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(selectDay),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              textBox(),
              imageList(),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: 200,
                height: 50,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => mapFeature(selectDay: selectDay),
                    );
                    Navigator.push(context, route);
                  },
                  label: Text('View Map'),
                  //color: Colors.blueGrey,
                  textColor: Colors.white,
                  icon: Icon(Icons.map),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => DayView(selectDay: selectDay),
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
}
