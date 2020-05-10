import 'package:firebase_auth/firebase_auth.dart';

class MyDataController{
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<FirebaseUser> signInAnon() async {
    FirebaseUser user = (await _firebaseAuth.signInAnonymously()).user;
    return user;
  }
}