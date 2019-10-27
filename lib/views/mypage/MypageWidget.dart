import 'package:codename/model/Genre.dart';
import 'package:codename/views/create/GameCreate.dart';
import 'package:flutter/material.dart';

class MypageWidget extends StatefulWidget {
  MypageWidget();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MypageWidget();
  }
}

class _MypageWidget extends State<MypageWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: QuestionCreateButton(),
    );
  }
  Widget QuestionCreateButton(){
    return FloatingActionButton.extended(
      label: Text("問題作成"),
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameCreate(genre: "animal",),
            )
        );
      },
    );
  }


}
