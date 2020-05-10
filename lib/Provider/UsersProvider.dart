import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/Controller/MyDataController.dart';
import 'package:codename/Model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersProvider{
  static const String _COLLECTION_NAME = "users";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);
  static User myUser;
  
  static Future<User> getMyUser() async {
    if(myUser == null){
      FirebaseUser user = await MyDataController.signInAnon();
      print("uid:" + user.uid);
      myUser = User(
        name: user.displayName,
        userId: user.uid,
      );
    }
    return myUser;
  }

}