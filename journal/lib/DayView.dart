import 'package:flutter/material.dart';
import 'main.dart';
import 'JournalEntry.dart';

class DayView extends StatefulWidget {
  final String selectDay;
  const DayView({Key key, this.selectDay}) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.selectDay),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
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
                      Route route = MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      );
                      Navigator.push(context, route);
                    },
                    label: Text('Calendar'),
                    //color: selectColor,
                    textColor: Colors.white,
                    icon: Icon(Icons.arrow_back),
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
                            JournalEntry(selectDay: widget.selectDay),
                      );
                      Navigator.push(context, route);
                    },
                    label: Text('Edit Journal'),
                    //color: selectColor,
                    textColor: Colors.white,
                    icon: Icon(Icons.explore),
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
