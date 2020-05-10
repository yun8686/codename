import 'dart:convert';

class Question{
  String title;
  List<Selection> selections;
  String documentId;
  int answers=0;  // 答えの数
  String creatorUid = "";
  Question({this.documentId, this.title, this.selections, this.creatorUid}){
    for(Selection selection in this.selections){
      if(selection.answer) answers++;
    }
  }
  Question.fromMap(Map<String, dynamic> map){
    this.documentId = map["id"];
    this.title = map["title"];
    this.creatorUid = map["creatorUid"];
    this.selections = (map["selections"] as List)
          .map((data)=>Selection(data["name"], data["answer"])).toList();
  }

  Map<String, dynamic> toMap(){
    return {
      "title": this.title,
      "creatorUid" : this.creatorUid,
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
