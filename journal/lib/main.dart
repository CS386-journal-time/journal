import 'package:flutter/material.dart';
import 'file:///C:/Users/burch/OneDrive/Documents/NAU%20Summer%202020/CS%20386/journal/journal/lib/models/user.dart';
import 'package:provider/provider.dart';
import 'package:journal/user_auth/interfaceWrapper.dart';
import 'package:journal/user_auth/serverAuth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: ServerAuth().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
