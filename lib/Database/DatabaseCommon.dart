import 'package:sqflite/sqflite.dart';

class DatabaseCommon{
  static const String TABLE_QUESTIONS = "Questions";
  static const String TABLE_SELECTIONS = "Selections";
  static Future<Database> getDatabase()async{
    Database database = await openDatabase('mydata.db', version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE $TABLE_QUESTIONS '
          '( id String PRIMARY KEY'
          ', title String'
          ');'
        );
        await db.execute(
          'CREATE TABLE $TABLE_SELECTIONS '
          '( question_id String '
          ', sequence int '
          ', name String'
          ', answer bool'
          ', PRIMARY KEY(question_id, sequence)'
          ');'
        );
    });
    return database;
  }
}