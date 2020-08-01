import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journal/journal/Photo.dart';
import 'package:journal/models/user.dart';
import 'package:journal/services/database.dart';
import 'package:provider/provider.dart';
import 'package:journal/shared/loading.dart';
import 'mapFeature.dart';


class JournalEntry extends StatefulWidget {

  final String selectDay;

  String localTextEntry;

  File localImageEntry;

  JournalEntry({this.selectDay});

  @override
  _JournalEntryState createState() => _JournalEntryState();
}


class _JournalEntryState extends State<JournalEntry> {


  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int maxLine = 30;

    // keeps track of user ID
    final user = Provider.of<User>(context);
    DatabaseService service = new DatabaseService(uid: user.uid);

    // instance of text and image state
    final _textController = TextEditingController();
    final Photo imageCard = new Photo();


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.selectDay),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              setState(() {
                widget.localTextEntry = _textController.text;
                widget.localImageEntry = imageCard.localImage;
              });
              service.updateUserData(widget.selectDay, widget.localTextEntry, widget.localImageEntry);
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.save),
            label: Text('Save'),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              height: maxLine * 8.0,
              child: TextField(
                enabled: true,
                controller: _textController,
                obscureText: false,
                keyboardType: TextInputType.multiline,
                maxLines: maxLine,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Journal Time',
                ),
              ),
            ),
            imageCard.createElement().widget,
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      print(user.uid);
                    },
                    label: Text('Calendar'),
                    //color: Colors.blueGrey,
                    textColor: Colors.white,
                    icon: Icon(Icons.explore),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                        builder: (context) =>
                            mapFeature(selectDay: widget.selectDay),
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
      ),
    );
  }
}
