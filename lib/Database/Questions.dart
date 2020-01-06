import 'package:codename/Database/DatabaseCommon.dart';
import 'package:codename/Model/Question.dart';
import 'package:sqflite/sqflite.dart';

class Questions{
  static Future<void> insert(Question question)async{
    Database database = await DatabaseCommon.getDatabase();
    await database.insert(DatabaseCommon.TABLE_QUESTIONS,{
      "id":question.documentId,
      "title": question.title,
    });
    int cnt = 0;
    for(Selection selection in question.selections){
      await database.insert(DatabaseCommon.TABLE_SELECTIONS, {
        "question_id": question.documentId,
        "sequence": ++cnt,
        "name": selection.name,
        "answer": selection.answer,
      });
    }
    question.selections.forEach((selection)async{
    });
    List<Map> list = await database.rawQuery('SELECT * FROM ' + DatabaseCommon.TABLE_QUESTIONS);
    print(list);
    list = await database.rawQuery("SELECT * FROM " + DatabaseCommon.TABLE_SELECTIONS);
    print(list);
  }
}