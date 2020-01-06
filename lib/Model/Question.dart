import 'dart:convert';

class Question{
  String title;
  List<Selection> selections;
  String documentId;
  int answers=0;  // 答えの数
  Question({this.documentId, this.title, this.selections}){
    for(Selection selection in this.selections){
      if(selection.answer) answers++;
    }
  }
  Question.fromMap(Map<String, String> map){
    this.documentId = map["id"];
    this.title = map["title"];
    this.selections = json.decode(map["selections"]);
  }

  Map<String, dynamic> toMap(){
    return {
      "title": this.title,
      "selections": this.selections.map((Selection selection){
        return {
          "answer": selection.answer,
          "name": selection.name,
        };
      }).toList(),
    };
  }
}

class Selection{
  String name;
  bool answer;
  Selection(this.name, this.answer);
}
