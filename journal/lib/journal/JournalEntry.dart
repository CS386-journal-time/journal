import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journal/journal/Photo.dart';
import 'package:journal/services/database.dart';
import 'package:provider/provider.dart';
import 'package:journal/models/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal/shared/loading.dart';




class JournalEntry extends StatefulWidget {

  final String selectDay;

  final String textEntry;

  JournalEntry({this.selectDay, this.textEntry});

  @override
  _JournalEntryState createState() => _JournalEntryState();
}

class _JournalEntryState extends State<JournalEntry> {

  String textEntry;

  File imageEntry;


  @override
  Widget build(BuildContext context) {

    final int maxLine = 30;

    final _textController = TextEditingController();

    Photo photo = new Photo();

    void dispose() {
      super.dispose();
    }

    Future saveDataToServer(String text) async {
      await Firestore.instance
          .collection('entries')
          .document('dates')
          .collection(widget.selectDay)
          .document('context')
          .setData({
            'textEntry' : textEntry,
            'imageEntry' : imageEntry,
          });
    }
   // final entries = Provider.of<List<Entry>>(context);


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.selectDay),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              setState(() {
                textEntry = _textController.text;
              });
              saveDataToServer(textEntry);
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
            Photo(),
          ],
        ),
      ),
    );
  }
}