import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal/services/database.dart';
import 'file:///C:/Users/burch/OneDrive/Documents/NAU%20Summer%202020/CS%20386/journal/journal/lib/models/user.dart';


// server authentication

class ServerAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

    // sign in email
  Future signInAccount(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


    // register
  Future registerAccount(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      FirebaseUser user = result.user;

      // create new document for user with uid
      await DatabaseService(uid: user.uid).updateUserData('', null);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

    // sign out
  Future signOut() async
  {
    try {
      return await _auth.signOut();
    } catch (error){
      print(error.toString());
      return null;
    }
  }
}