import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:codename/Model/Question.dart';
import 'package:codename/Model/Review.dart';
import 'package:codename/Provider/QuestionsProvider.dart';
import 'package:codename/Provider/ReviewsProvider.dart';
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
  String questionId = "";
  String title = "";
  List<_BoardSelection> selections = List<_BoardSelection>();
  int life = 3;
  int selected = 0;
  int answers = 0;
  double progress = 0.0;
  double limittime = 180000.0;

  @override
  void initState() {
    super.initState();
    QuestionsProvider.getRandomQuestion().then((Question question) {
      if (mounted) {
        setState(() {
          questionId = question.documentId;
          title = question.title;
          selections = question.selections.map((Selection selection) {
            return _BoardSelection.fromSelection(selection);
          }).toList();
          selected = 0;
          answers = question.answers;
        });
      }
      const timeout = const Duration(milliseconds: 1000);
      Timer.periodic(timeout, (Timer t) {
        if (mounted) {
          if(!isGaming){
            t.cancel();
          }else{
            setState(() {
              progress = progress + 1000 / limittime;
              if (progress > 1) {
                progress = 0.0;
              }
            });
          }
        } else {
          t.cancel();
        }
      });
    });
  }

  List<bool> selectedList = List<bool>();
  bool isGaming = true;

  @override
  Widget build(BuildContext context) {
    return gameView(context);
  }

  Widget gameView(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30,),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.favorite, color: Colors.red,),
                Text("×" + life.toString(),
                  style: TextStyle(fontSize: 20),),
              ]
          ),
          SizedBox(
            width: double.infinity,
            height: 90.0,
            child: Center(
              child: AutoSizeText(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
          ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(selected.toString() + "/" + answers.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 40,),
          LinearProgressIndicator(value: progress),
          Expanded(child:
          GridView.count(
            crossAxisCount: 5,
            children: selections.map((card) {
              return new GridTile(
                  child: GestureDetector(
                    child: Card(
                      color: card.selected ? (card.answer
                          ? Colors.green
                          : Colors.red) : Colors.white,
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Text(card.name),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      if (isGaming) {
                        setState(() {
                          if (!card.selected) {
                            card.selected = true;
                            if (card.answer)
                              selected++;
                            else
                              life--;
                          }
                        });
                      }
                      showResultDialog();
                    },
                  )
              );
            }).toList(),
          ),
          )
        ]
    );
  }

  int starNum;
  String comment;
  void showResultDialog() {
    if (life > 0 && selected != answers) return;
    isGaming = false;
    String title = selected == answers ? "Win" : "Lose";

    getReview().then((Review review) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: ReviewWidget(
              onChange:(int starNum, String comment){
                this.starNum = starNum;
                this.comment = comment;
              }
            ),
            actions: <Widget>[
              // ボタン
              FlatButton(
                child: Text("評価しない"),
                onPressed: ()=>Navigator.pop(context),
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () async {
                  ReviewsProvider.addComment(questionId, Comment(
                    star: this.starNum,
                    comment: this.comment,
                  ));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    });
  }

  Review review;

  Future<Review> getReview() async {
    if (review == null) {
      review = await ReviewsProvider.getReview(questionId);
    }
    return review;
  }


}

class ReviewWidget extends StatefulWidget{
  Function(int,String) onChange;
  ReviewWidget({this.onChange});
  @override
  State<StatefulWidget> createState() {
    return ReviewState(onChange);
  }
}
class ReviewState extends State<ReviewWidget>{
  int starnum = 5;
  String comment="";
  Function(int,String) onChange;
  ReviewState(this.onChange);

  @override
  void setState(fn) {
    super.setState(fn);
    onChange(starnum, comment);
  }
  @override
  Widget build(BuildContext context) {
    FocusNode _commentFocusNode = FocusNode();

    return GestureDetector(
      onTap: () {
        _commentFocusNode.unfocus();
      },
      child: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("この問題はどうでしたか？"),
            Row(
              children: starIcons(40.0),
            ),
            Text("コメントを入力"),
            TextField(
              enabled: true,
              maxLength: 200,
              maxLengthEnforced: false,
              style: TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: 3,
              focusNode: _commentFocusNode,
              onChanged: (text){
                setState(() {
                  this.comment = text;
                });
              },
            ),
            Text("コメントを見る(1件)"),
          ],
        ),
      ),
    );
  }
  List<Widget> starIcons(double size) {
    List<Widget> list = List<Widget>();
    for (int i = 1; i <= 5; i++) {
      list.add(GestureDetector(
          onTap: () {
            setState(() {
              starnum = i;
            });
          }, child: Icon(
        i <= starnum ? Icons.star : Icons.star_border,
        size: size,
      )));
    }
    return list;
  }
}
