import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journal/journal/Photo.dart';


class JournalEntry extends StatelessWidget {
  final String selectDay;
  String textEntry;
  List<File> imageServerList = new List(3);
  List<double> coordinatesList = new List(2);


  JournalEntry({this.selectDay});

  final myController = TextEditingController();

  void dispose() {
    myController.dispose();
  }

void saveToDatabase()
{
  coordinatesList[0] = 35.1983;
  coordinatesList[1] = 111.6513;

  //DatabaseService data = new DatabaseService();
  //data.updateEntryData(textEntry, imageServerList, coordinatesList);
}

  // text input
  Widget textBox() {
    final int maxLine = 30;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      height: maxLine * 8.0,
      child: TextField(
        controller: myController,
        keyboardType: TextInputType.multiline,
        maxLines: maxLine,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Journal Time',
        ),
      ),
    );
  }

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
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveToDatabase();
        },
        label: Text('Save'),
        icon: Icon(FontAwesomeIcons.save),
        backgroundColor: Colors.green[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
