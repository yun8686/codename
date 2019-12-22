class Question{
  String title;
  List<Selection> selections;
  int answers=0;  // 答えの数
  Question({this.title, this.selections}){
    for(Selection selection in this.selections){
      if(selection.answer) answers++;
    }
  }
}

class Selection{
  String name;
  bool answer;
  Selection(this.name, this.answer);
}
