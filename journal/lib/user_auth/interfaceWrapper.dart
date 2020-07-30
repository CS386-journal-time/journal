import 'package:flutter/material.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/models/user.dart';
import 'package:provider/provider.dart';
import 'package:journal/journal//Calendar.dart';


// wrapper loads next screen based on log in status

class Wrapper extends StatefulWidget {
  @override
  _Wrapper createState() => _Wrapper();
}

class _Wrapper extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null)
    {
      return Authentication();
    }
    else{
      return Calendar();
    }
  }
}

