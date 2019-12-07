import 'package:codename/model/Questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding:false,
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: (){},
          ),
        ],
        title: new Text('問題の登録'),
      ),
      body: Column(
        children: <Widget>[
      Padding(
        child: TextField(
          onChanged: (String title){
            _question.setTitle(title);
          },
          decoration: InputDecoration(
            labelText: _question.title.length == 0?"キーワードを入力してください":"キーワード",
            border: OutlineInputBorder(),
            hintText: "例：海の生き物",
          ),
        ),
        padding: EdgeInsets.all(20.0),
      ),
          _listZone(),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: RaisedButton(
              child: const Text("登録"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                if(_question.title.length == 0){
                  showToast("キーワードを入力してください");
                  return;
                }
                if(CARDS.indexWhere((data)=>data.answer) == -1){
                  showToast("正解を一つ以上選択してください");
                  return;
                }
                sendToServer(context);
              },
            ),
        ),

        ],
      ),
    );
  }

  bool sending = false;
  void sendToServer(BuildContext context){
    if(sending) return;
    sending = true;

    _question.selections = CARDS.map((Data data){
      return data.toSelection();
    }).toList();
    _question.saveServer().then((v){
      showToast("作成しました");
      Navigator.pop(context);
    });
  }

  void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  Widget _listZone(){
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
                  CARDS[index].changeAnswer();
                });
              },
              onLongPressStart: (v){
                CARDS[index].changeName(context);
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
  void changeAnswer(){
    this.answer = !this.answer;
  }
  void changeName(BuildContext context){
    TextEditingController textEditingController = TextEditingController(text: this.name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('単語を編集'),
          content: TextField(
            controller: textEditingController,
            onChanged: (value){
              this.name = value;
            },
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
  Selection toSelection(){
    return Selection(this.name, this.answer);
  }
}