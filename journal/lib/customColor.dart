import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:journal/main.dart';

import 'main.dart';


class customColor extends StatefulWidget {

  Color canvasColor;
  Color backColor;

  customColor({Key key, Key back, this.canvasColor, this.backColor});

  @override
  _customColor createState() => _customColor(canvasColor: canvasColor, backColor: backColor);
}

class _customColor extends State<customColor> {

  _customColor({Key key, Key back, this.canvasColor, this.backColor});

  Color canvasColor;
  Color backColor;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Center(

            child: Text('Personalize'),
        ),
      ),

      body: ListView(


          children: <Widget>[

                Row(
                  children: <Widget>[
                    Column(

                      children: <Widget>[
                      RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => MaterialApp(theme: ThemeData( primaryColor: backColor, canvasColor: canvasColor), home:MyHomePage()),
                    );
                    Navigator.push(context, route);
                  },
                  child: Text('Submit Changes'),
                ),
                        Container(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Text('new background color'),
                          ),
                          decoration: new BoxDecoration(
                            color: backColor,
                            border: Border.all(width: 3),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Text('new canvas color'),
                          ),
                          decoration: new BoxDecoration(
                            color: canvasColor,
                            border: Border.all(width: 3),
                          ),
                        ),

                        RaisedButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(
                              builder: (context) => backCustomColor(),
                            );
                            Navigator.push(context, route);
                          },
                          child: Text('Choose new colors'),
                        ),
      ],
    ),
                ],
                ),
          ],

      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class backCustomColor extends StatefulWidget {
  @override
  _backCustomColor createState() => _backCustomColor();
}
class _backCustomColor extends State<backCustomColor> {
  Color backColor;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('color'),

      ),
      body: Center(

        child: Column(

          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: backColor,
                ),
                child: RaisedButton(

                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => canvasCustomColor(backColor: backColor),
                    );
                    Navigator.push(context, route);
                  },
                  child: Text('Submit Background Color'),
                )

            ),

            new ColorPicker(

                color: Colors.blue,
                onChanged: (value){
                  setState(() {
                    backColor = value;
                  });
                }
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class canvasCustomColor extends StatefulWidget {
  Color backColor;
  canvasCustomColor({Key key, this.backColor}) : super (key: key);
  @override
  _canvasCustomColor createState() => _canvasCustomColor(backColor: backColor);
}
class _canvasCustomColor extends State<canvasCustomColor> {
  _canvasCustomColor({Key key, this.backColor});

  Color backColor;
  Color canvasColor;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('color'),

      ),
      body: Center(

        child: Column(

          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: canvasColor,
                ),
                child: RaisedButton(

                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => customColor(backColor: backColor, canvasColor: canvasColor,),

                    );
                    Navigator.push(context, route);
                  },
                  child: Text('Submit Canvas Color'),
                )

            ),

            new ColorPicker(
                color: Colors.blue,
                onChanged: (value){
                  setState(() {
                    canvasColor = value;
                  });
                }
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
