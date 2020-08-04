import 'package:journal/models/entry.dart';
import 'package:journal/models/user.dart';
import 'package:journal/services/authentication.dart';
import 'package:test/test.dart';

void main() {


  // user model creates the user and sets the user ID to null until registration
  test('User is created correctly', () {

    User user = new User();

    expect(user.uid, null);
  });


  // Entry model creates the entry and sets all fields to null
  // until an entry is formed for upload
  test('Entry is created correctly', () {

    Entry entry = new Entry();

    expect(entry.textEntry, null);
  });



}

