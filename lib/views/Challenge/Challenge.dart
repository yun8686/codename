import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/Model/Question.dart';
import 'package:codename/Provider/QuestionsProvider.dart';
import 'package:flutter/material.dart';

class Challenge extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(child: _QuestionArea()),
      ),
    );
  }


}

class _QuestionArea extends StatefulWidget {
  _QuestionAreaState createState() =>_QuestionAreaState();
}


class _BoardSelection extends Selection{
  bool selected = false;
  _BoardSelection(String name, bool answer) : super(name, answer);
  _BoardSelection.fromSelection(Selection selection) : super(selection.name, selection.answer);
}

class _QuestionAreaState extends State<_QuestionArea> {
  String title = "";
  List<_BoardSelection> selections = List<_BoardSelection>();
  int selected = 0;
  int answers = 0;
  double progress = 0.0;
  double limittime = 180000.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    QuestionsProvider.getRandomQuestion().then((Question question){
      if (mounted) {
        setState(() {
          title = question.title;
          selections = question.selections.map((Selection selection){
            return _BoardSelection.fromSelection(selection);
          });
          selected = 0;
          answers = question.answers;
        });
      }
      const timeout = const Duration(milliseconds: 1000);
      Timer.periodic(timeout, (Timer t) {
        if (mounted){
          setState(() {
            progress = progress + 1000/limittime;
            if (progress > 1) {
              progress = 0.0;
            }
          });
        }else{
          t.cancel();
        }
      });
    });
  }

  List<bool> selectedList = List<bool>();
  @override
  Widget build(BuildContext context){
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 100.0,
            child: Center(
              child:Column(
                children: <Widget>[
                  Text(title + "を探せ！",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  Text(selected.toString() + "/" + answers.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          LinearProgressIndicator(value: progress),
          Expanded(child:
            GridView.count(
              crossAxisCount: 5,
              children: selections.map((card) {
                return new GridTile(
                    child: GestureDetector(
                      child: Card(
                        color: card.answer ? Colors.red : Colors.green,
                        child: new Center(
                          child: new Text(card.name),
                        ),
                      ),
                      onTap: (){
                        print("tap");
                        setState(() {
                          card.answer = !card.answer;
                        });
                      },
                    )
                );
              }).toList(),
            ),
          )
        ]
    );
  }
}