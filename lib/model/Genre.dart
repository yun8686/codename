import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/Library/SQLiteDatabase.dart';
import 'package:sqflite/sqflite.dart';

class Genre{
  static const String _COLLECTION_NAME = "genre";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);

  static Future<List<Genre>> getAll()async{
    print("Genre getall");
    List<Genre> genreList = List<Genre>();
    await collection.orderBy("sort").getDocuments().then((QuerySnapshot snapshot){
      genreList = snapshot.documents.map((DocumentSnapshot document){
        return Genre(
          name: document.data['name'],
          id: document.data['id'],
          sort: document.data['sort'],
        );
      }).toList();
    });
    await _setDB(genreList);
    await _getFromDB();
    return genreList;
  }

  static Future<List<Genre>> _getFromDB()async{
    Database database = await MySQLiteDatabase.getDatabase();
    List<Map> dataList = await database.query(Tables.Genre);
    return dataList.map((data){
      print("db");
      print(data);
      return Genre(
        name: data['name'],
        id: data['id'],
        sort: data['sort'],
      );
    }).toList();
  }

  static Future<void> _setDB(List<Genre> genreList)async{
    Database database = await MySQLiteDatabase.getDatabase();
    await database.delete(Tables.Genre);
    await Future.wait(genreList.map((Genre genre){
      return database.insert(Tables.Genre, {
        'id': genre.id,
        'name': genre.name,
        'sort': genre.sort,
      });
    }));

  }

  String name;
  String id;
  int sort;
  Genre({this.name, this.id, this.sort});
}