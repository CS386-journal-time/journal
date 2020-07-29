import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:journal/DayView.dart';
import 'package:intl/intl.dart';
import 'package:journal/customColor.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  DateTime choiceDay;
  String selectDay;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatDate() {
    DateFormat formatter = DateFormat('LLLL d, y');
    String formattedDate = formatter.format(choiceDay);
    return '$formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Journal Time'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange[400],
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onCalendarCreated: (date, now, month) {
                choiceDay = DateTime.now();
                selectDay = formatDate();
              },
              onDaySelected: (date, events) {
                choiceDay = date;
                selectDay = formatDate();
              },
              calendarController: _controller,
            ),
            SizedBox(
              height: 100,
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
                        builder: (context) => DayView(selectDay: selectDay),
                      );
                      Navigator.push(context, route);
                    },
                    label: Text('View Journal'),
                    //color: Colors.blueGrey,
                    textColor: Colors.white,
                    icon: Icon(Icons.explore),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Personalize Color"),
              trailing: RaisedButton(
                onPressed: () {
                  Route route = MaterialPageRoute(
                    builder: (context) => customColor(),
                  );
                  Navigator.push(context, route);
                },
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
