import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:journal/journal/JournalEntry.dart';
import 'package:journal/models/entry.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/services/database.dart';
import 'package:journal/shared/loading.dart';
import 'package:journal/user_auth/serverAuth.dart';
import 'package:provider/provider.dart';
import 'package:journal/journal/Photo.dart';

class DayView extends StatefulWidget {

  final String selectDay;




  DayView({Key key, this.selectDay}) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {

  final int maxLine = 30;

  String textEntry;

  final _textController = TextEditingController();

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: Firestore.instance
          .collection('entries')
          .document('dates')
          .collection(widget.selectDay)
          .document('context')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {


          // bug with new data entries
          return Loading();
        } else {
          DocumentSnapshot docSnap = snapshot.data;
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
                    Route route = MaterialPageRoute(
                      builder: (context) =>
                          JournalEntry(
                            selectDay: widget.selectDay,
                            textEntry: textEntry,
                          ),
                    );
                    Navigator.push(context, route);
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
              ],
            ),
            body: Center(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        height: maxLine * 8.0,
                        child: docSnap['textEntry'] == ''
                          ? TextField(
                              enabled: false,
                              controller: _textController,
                              obscureText: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: maxLine,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Journal Time',
                              ),
                            )
                        : Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                            height: maxLine * 8.0,
                            child: Text(docSnap['textEntry'])
                        ),
                      ),
                    ],
                    ),
                  ],
                  ),
              ),
            );
        }
      },
    );
  }
}
