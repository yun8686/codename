import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/model/WordSet.dart';

class Question{
  static const String _COLLECTION_NAME = "questions";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);


  int mode;   // 1: ゲームモード, 2:作成モード
  String genre;
  String title;
  List<Selection> selections = List<Selection>();
  Question(this.title, this.selections){
    mode = 1;
    selections = shuffle(selections);
  }

  Question.createGame({this.genre}){
    this.mode = 2;
    this.title="";
  }
  void setTitle(String title){
    this.title = title;
  }
  Future setSelection(){
    return WordSet.getWordSet(this.genre).then((DocumentSnapshot document){
      List<String> wordList = List.from(document.data["words"]);
      wordList = shuffle(wordList);
      wordList.removeRange(25, wordList.length);
      wordList.forEach((String name){
        this.selections.add(Selection(name, false));
      });
    });
  }
  Future<DocumentReference> saveServer(){
    return collection.add({
      'title': this.title,
      'selections': this.selections.map((Selection selection){
        return {
          'name': selection.name,
          'answer': selection.answer,
        };
      }).toList(),
    });
  }

  static Future<List<Question>> getQuestionList({String genre})async{
    QuerySnapshot querySnapshot = await collection.getDocuments();
    List<Question> questionList = List<Question>();
    querySnapshot.documents.forEach((DocumentSnapshot document){
      questionList.add(Question(document.data['title'],
        List<Map>.from(document.data["selections"]).map((Map map){
          return Selection(map['name'], map['answer']);
        }).toList())
      );
    });
    print(questionList);
    return questionList;
  }

  static List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

}

class Selection{
  String name;
  bool answer;
  Selection(this.name, this.answer);
}
