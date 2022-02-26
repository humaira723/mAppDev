// ignore_for_file: unnecessary_null_comparison

import 'package:fanpage_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

//methods that will interact with firebase auth
class AuthService {
  // _ means private(only used in this file)
  //.instance gives us access to firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on Firebase
  User? _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid)
        : null; // if there is a user then get back user id
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in email/pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email/pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
