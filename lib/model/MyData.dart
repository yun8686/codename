import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/Library/SQLiteDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

class Mydata{
  static const String _COLLECTION_NAME = "mydata";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);

  static Future<Mydata> getMyData()async{
    return _getFromDB();
  }
  static Future<void> updateName(Mydata mydata)async{
    await _updateDB(mydata);
  }

  static Future<Mydata> _getFromDB()async{
    Database database = await MySQLiteDatabase.getDatabase();
    List<Map> dataList = await database.query(Tables.Mydata);
    String uid = await _doAnonymousLogin();
    if(dataList.length == 0){
      // 未作成の場合は初期データ作成
      await _setDB(Mydata(name: "未作成", id: uid));
      dataList = await database.query(Tables.Mydata);
    }
    return Mydata(
      name: dataList[0]['name'],
      id: uid,
    );
  }

  static Future<void> _setDB(Mydata mydata)async{
    Database database = await MySQLiteDatabase.getDatabase();
    collection.document(mydata.id).setData({
      'name': mydata.name,
      'id': mydata.id,
    });
    database.insert(Tables.Mydata, {
      'name': mydata.name,
      'id': mydata.id,
    });
  }

  static Future<void> _updateDB(Mydata mydata)async{
    Database database = await MySQLiteDatabase.getDatabase();
    await collection.document(mydata.id).updateData({
      "name": mydata.name,
    });
    database.update(Tables.Mydata, {"name": mydata.name},
      where: "id = ?",
      whereArgs: [mydata.id],
    );
  }

  String name;
  String id;
  Mydata({this.name, this.id});

  static Future<String> _doAnonymousLogin()async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    String uid = (await _auth.signInAnonymously()).uid;
    print(uid);
    return uid;
  }
}