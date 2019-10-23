import 'package:codename/model/Questions.dart';
import 'package:codename/views/game/GameHero.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  final Question question;
  GameView({Key key, this.question}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState(question);
}

class _GameViewState extends State<GameView> {
  int _counter = 0;
  Question question;
  List<Data> CARDS;
  String title;
  _GameViewState(Question question){
    this.question = question;
    title = question.title;
    CARDS = question.selections.map((select){
      return Data(select.name, select.answer);
    }).toList();
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('連想ゲーム'),
      ),
      body: Column(
        children: <Widget>[
          GameHero.createTitleCard(question),
          _listZone(this.CARDS),
          numZone(this.CARDS),
        ],
      ),
    );
  }



  Widget _listZone(List<Data> CARDS){
    return Expanded(child:
    GridView.count(
      crossAxisCount: 5,
      children: new List<Widget>.generate(25, (index) {
        final Data card = CARDS[index%CARDS.length];
        return new GridTile(
            child: GestureDetector(
              child: new Card(
                color: card.color,
                child: new Center(
                  child: new Text(card.name),
                ),
              ),
              onTap: (){
                setState(() {
                  card.open();
                });
              },
            )
        );
      }),
    ),
    );
  }

  Widget numZone(List<Data> CARDS){
    int all=0,now=0;
    CARDS.forEach((data){
      if(data.answer){
        all++;
        if(data.status == 1){
          now++;
        }
      }
    });
    return Text(
      "$all個中 $now個正解",
      style: TextStyle(
          fontSize: 40
      ),

    );
  }
}

class Data{
  String name;
  bool answer;
  Color color;
  int status; //0: nonopen, 1:open
  Data(this.name, this.answer){
    color = Colors.blue.shade200;
    status = 0;
  }
  void open(){
    if(this.answer){
      color = Colors.green;
    }else{
      color = Colors.red;
    }
    status = 1;
  }
}