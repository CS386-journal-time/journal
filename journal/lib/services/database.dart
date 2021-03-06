import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  String imageURL;

  DatabaseService({this.uid});

  // retrieves user document location within firebase
  final CollectionReference entryCollection =
      Firestore.instance.collection('entries');

  // updates the database within the firebase
  Future updateUserData(
      String date, String textEntry, File image, String weatherText) async {
    StorageReference entryStorage =
        FirebaseStorage.instance.ref().child(uid).child(date);

    if (image != null) {
      StorageUploadTask uploadTask = entryStorage.child('image').putFile(image);

      imageURL = await (await uploadTask.onComplete).ref.getDownloadURL();
    }

    return await entryCollection
        .document(uid)
        .collection(date)
        .document('context')
        .setData({
      'textEntry': textEntry,
      'imageURL': imageURL,
      'weatherText': weatherText
    });
  }
}
