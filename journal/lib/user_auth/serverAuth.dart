import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal/models/user.dart';


// server authentication for user sign in and registration

class ServerAuth {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  // user authentication stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in user
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


  // register new user
  Future registerAccount(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out user
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