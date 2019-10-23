import 'package:codename/model/Questions.dart';
import 'package:codename/views/game/GameHero.dart';
import 'package:codename/views/game/GameView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameCreate extends StatefulWidget {
  String genre;
  GameCreate({Key key, this.genre}) : super(key: key);

  @override
  _GameCreateState createState() => _GameCreateState(
    genre: genre,
  );
}

class _GameCreateState extends State<GameCreate> {
  List<Data> CARDS = List<Data>.generate(25, (i)=>Data.empty());
  Question _question;
  _GameCreateState({String genre}){
    _question = Question.createGame(genre:genre);
    _question.setSelection().then((v){
      setState(() {
        CARDS = _question.selections.map((Selection selection){
          return Data.fromSelection(selection);
        }).toList();
      });
    });
  }

  bool sending = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding:false,
      appBar: new AppBar(
        title: new Text('連想ゲーム'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String title){
              _question.setTitle(title);
            },
          ),
          _listZone(CARDS),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: RaisedButton(
              child: Text("作成"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                if(!sending){
                  sending = true;
                  _question.selections = CARDS.map((Data data){
                    return data.toSelection();
                  }).toList();
                  _question.saveServer().then((v){
                    Navigator.pop(context);
                  });
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("作成しました"),
                  ));
                }
              },
            ),
        ),

        ],
      ),
    );
  }

  Widget _listZone(List<Data> CARDS){
    return Expanded(child:
    GridView.count(
      crossAxisCount: 5,
      children: new List<Widget>.generate(25, (index) {
        return new GridTile(
            child: GestureDetector(
              child: new Card(
                color: CARDS[index].getColor(),
                child: new Center(
                  child: new Text(CARDS.length>index?CARDS[index].name:""),
                ),
              ),
              onTap: (){
                setState(() {
                  CARDS[index].open();
                });
              },
            )
        );
      }),
    ),
    );
  }
}


class Data{
  String name;
  bool answer;
  Color color;
  Data(this.name){
    color = Colors.blue.shade200;
    this.answer = false;
  }
  Data.fromSelection(Selection selection){
    this.name = selection.name;
    this.answer = selection.answer;
    this.color = Colors.blue.shade200;
  }
  Data.empty(){
    this.name = "";
    color = Colors.blue.shade200;
    this.answer = false;
  }
  Color getColor(){
    if(this.answer) return Colors.green;
    else return Colors.blue.shade200;
  }
  void open(){
    this.answer = !this.answer;
  }
  Selection toSelection(){
    return Selection(this.name, this.answer);
  }
}