import 'package:cloud_firestore/cloud_firestore.dart';

class WordSet{
  static const String _COLLECTION_NAME = "wordset";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);

  static Future<DocumentSnapshot> getWordSet(String genre){
    return collection.document(genre).get();
  }
}