import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Tables{
  static final String Genre = "Genre";
  static final String Mydata = "Mydata";
}

class MySQLiteDatabase {
  static Database db;
  static void _init() async {
    if(db != null) return;
    print(await getDatabasesPath());
    final path = join(await getDatabasesPath(), "wordass.db");
    // openDatabaseメソッドを使用することでDBインスタンスを取得することができます。
    db = await openDatabase(path, version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE ${Tables.Genre}
          (
            id TEXT,
            name TEXT,
            sort integer primary key
          );
        """);
        newDb.execute("""
        CREATE TABLE ${Tables.Mydata}
        (
            id TEXT primary key,
            name TEXT
        );
        """);
      },
    );
  }

  static Future<Database> getDatabase()async{
    await _init();
    return db;
  }
}
