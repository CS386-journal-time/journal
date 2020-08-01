import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journal/journal/JournalEntry.dart';
import 'package:journal/models/user.dart';
import 'package:journal/services/database.dart';
import 'package:provider/provider.dart';
import 'package:journal/journal/Photo.dart';

class DayView extends StatefulWidget {

  final String selectDay;

  DayView({Key key, this.selectDay}) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}


class _DayViewState extends State<DayView> {

  String pulledTextEntry;

  String pulledImageURL;

  final int maxLine = 30;

  final _textController = TextEditingController();

  final Photo imageCard = new Photo();

  void dispose() {
    super.dispose();
  }

  // image card that pulls image from the server
  Widget imageCardServer() {
    return Container(
      height: 200.0,
      width: 400.0,
      margin: EdgeInsets.all(5.0),
      child: GestureDetector(
        child: Container(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.grey[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Container(
              child: pulledImageURL == ''
                  ? Icon(FontAwesomeIcons.image)
                  : Image.network(pulledImageURL, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // keeps track of user ID
    final user = Provider.of<User>(context);
    DatabaseService service = new DatabaseService(uid: user.uid);


    // take as snapshot of user's data
    Stream<DocumentSnapshot> dateDoc = service.entryCollection
          .document(user.uid)
          .collection(widget.selectDay)
          .document('context').snapshots();

    // builds widgets wth data returned from firebase
    return StreamBuilder<DocumentSnapshot>(
      stream: dateDoc,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          var entryDocument = snapshot.data.data;

          if(entryDocument != null)
          {
            pulledTextEntry = entryDocument['textEntry'];

            pulledImageURL = entryDocument['imageURL'];
          }

        else
          {

            pulledTextEntry = '';

            pulledImageURL =  '';
          }

        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(widget.selectDay),
            ),
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Route route = MaterialPageRoute(
                    builder: (context) =>
                        JournalEntry(
                          selectDay: widget.selectDay,
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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  height: maxLine * 8.0,
                  child: 'Text' == ''
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
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    height: maxLine * 8.0,
                    child: Text(pulledTextEntry),
                  ),
                ),
                Row(
                  children: <Widget>[
                    imageCardServer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}