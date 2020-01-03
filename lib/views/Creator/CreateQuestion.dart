import 'package:auto_size_text/auto_size_text.dart';
import 'package:codename/Model/Question.dart';
import 'package:codename/Model/WordSet.dart';
import 'package:codename/Provider/WordSetProvider.dart';
import 'package:flutter/material.dart';

class CreateQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("問題を作成")),
      body: SafeArea(
        child: _QuestionArea(),
      ),
    );
  }
}

class _BoardSelection extends Selection{
  bool selected = false;
  _BoardSelection(String name, bool answer) : super(name, answer);
  _BoardSelection.fromSelection(Selection selection) : super(selection.name, selection.answer);
}

class _QuestionArea extends StatefulWidget {
  _QuestionAreaState createState() =>_QuestionAreaState();
}

class _QuestionAreaState extends State<_QuestionArea> {
  List<_BoardSelection> wordList = [];
  String title = "〇〇を探せ！";
  @override
  void initState() {
    // TODO: implement initState
    WordSetProvider.getRandomWords("animal", 25).then((WordSet wordlist){
      setState(() {
        this.wordList = wordlist.words.map((word){
          return _BoardSelection(word, false);
        }).toList();
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: (){
              _displayDialog(context, this.title, (String value){
                setState(() {
                  this.title = value;
                });
              });
            },
            child: SizedBox(
              width: double.infinity,
              height: 130.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: AutoSizeText(this.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    child: Icon(Icons.mode_edit),
                    alignment: Alignment.bottomRight,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Expanded(child:
            GridView.count(
              crossAxisCount: 5,
              children: wordList.map((_BoardSelection selection) {
                return new GridTile(
                    child: GestureDetector(
                      child: Card(
                        color: selection.answer?Colors.green:null,
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Text(selection.name),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selection.answer = !selection.answer;
                        });
                      },
                      onLongPress: (){
                        _displayDialog(
                          context, selection.name,(String newName){
                            setState(() {
                              selection.name = newName;
                            });
                          }
                        );
                      },
                    )
                );
              }).toList(),
            ),
          ),
          button(buttonText: "作成する"),
          SizedBox(height: 40,),
        ],
    );
  }

  _displayDialog(BuildContext context, String defText, Function(String) onChanged) async {
    TextEditingController _textFieldController = TextEditingController(text:defText);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(

              controller: _textFieldController,
              decoration: InputDecoration(hintText: "TextField in Dialog"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  onChanged(_textFieldController.text);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  RaisedButton button({
    String buttonText,
    Function onPressed ,
  }) {
    return RaisedButton(
      onPressed: onPressed??(){},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blueAccent
        ),
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text(buttonText),),
        width: 200,
      ),
    );
  }
}
