import 'package:flutter/material.dart';

final myController = TextEditingController();

void dispose() {
  myController.dispose();
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
