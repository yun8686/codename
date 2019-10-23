import 'package:cloud_firestore/cloud_firestore.dart';

class Genre{
  static const String _COLLECTION_NAME = "genre";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);

  static Future<List<Genre>> getAll(){
    return collection.orderBy("sort").getDocuments().then((QuerySnapshot snapshot){
      return snapshot.documents.map((DocumentSnapshot document){
        return Genre(
          name: document.data['name'],
          id: document.data['id'],
        );
      }).toList();
    });
  }

  String name;
  String id;
  Genre({this.name, this.id});
}