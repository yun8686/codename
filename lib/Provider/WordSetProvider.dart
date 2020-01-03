import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/Model/WordSet.dart';

class WordSetProvider {
  static const String _COLLECTION_NAME = "wordset";
  static CollectionReference collection = Firestore.instance.collection(
      _COLLECTION_NAME);

  static Future<WordSet> getRandomWords(String documentId, int size)async{
    DocumentSnapshot snapshot = await collection.document(documentId).get();
    List<String> list = (snapshot['words'] as List).map((word){
      return word.toString();
    }).toList();
    list.shuffle();
    list.removeRange(size, list.length);
    return WordSet(words: list);
  }
}