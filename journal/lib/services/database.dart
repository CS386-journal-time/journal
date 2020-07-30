import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal/models/entry.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference entryCollection =
    Firestore.instance.collection('entries');


  Future updateUserData(String textEntry, List imageEntry) async {

    return await entryCollection.document('dates');
  }

  // entry list from snapshot
  List<Entry> _entryListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Entry(
        textEntry: doc.data['textEntry'] ?? '',
        imageEntry: doc.data['imageEntry'] ?? null,
      );
    }).toList();
  }


  Stream<List> get entries {
    return entryCollection.snapshots().map(_entryListFromSnapshot);
  }

}