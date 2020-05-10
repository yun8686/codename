import 'package:auto_size_text/auto_size_text.dart';
import 'package:codename/Model/Question.dart';
import 'package:codename/Model/User.dart';
import 'package:codename/Model/WordSet.dart';
import 'package:codename/Provider/QuestionsProvider.dart';
import 'package:codename/Provider/UsersProvider.dart';
import 'package:codename/Provider/WordSetProvider.dart';
import 'package:flutter/material.dart';

class CreateQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuestionArea();
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
  static const String WORD_CLASS = "animal";
  List<_BoardSelection> wordList = [];
  String title = "";
  @override
  void initState() {
    WordSetProvider.getRandomWords(WORD_CLASS, 25).then((WordSet wordlist){
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
    return Scaffold(
      appBar: AppBar(
        title: Text("問題を作成"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white,),
            onPressed: (){
              WordSetProvider.getRandomWords(WORD_CLASS, 25).then((WordSet wordlist){
                setState(() {
                  this.wordList = wordlist.words.map((word){
                    return _BoardSelection(word, false);
                  }).toList();
                });
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: mainContant(context),
      ),
    );
  }
  Widget mainContant(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: (){
              _displayDialog(context, this.title,
                title: "タイトルを変更",
                hintText: "問題のタイトル",
                maxLength: 20,
                onChanged: (String value){
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
                    child: AutoSizeText(
                      this.title==""?"タイトルを入力":this.title,
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
                          context, selection.name,
                          title: "選択肢を変更",
                          maxLength: 10,
                          onChanged: (String newName){
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
          button(
            buttonText: "作成する",
            onPressed: (){
              doCreate(context);
            },
          ),
          SizedBox(height: 40,),
        ],
    );
  }

  _displayDialog(BuildContext context, String defText, {
    Function (String) onChanged,
    String title,
    String hintText,
    int maxLength,
  }) async {
    final TextEditingController _textFieldController = TextEditingController(text:defText);
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key:formKey,
            child: AlertDialog(
            title: Text(title),
            content: TextFormField(
              maxLength: maxLength??20,
              decoration: InputDecoration(hintText: hintText??""),
              controller: _textFieldController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'テキストを入力してください。';
                }
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  if(formKey.currentState.validate()){
                    onChanged(_textFieldController.text);
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
          );
        });
  }

  Future doCreate(BuildContext context)async{
    User user = await UsersProvider.getMyUser();
    int ansCount = wordList.where((v){return v.answer;}).length;
    print("ansCount: " + ansCount.toString());
    if(ansCount == 0){
      await ShowSimpleDialog("答えを一つ以上設定してください");
      return;
    }
    if(this.title == ""){
      await ShowSimpleDialog("タイトルを入力してください");
      return;
    }
    await QuestionsProvider.putQuestion(Question(
      documentId: null,
      title: this.title,
      creatorUid: user.userId,
      selections: wordList,
    ));
    print("作成します");
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

  Future<void> ShowSimpleDialog(String text)async{
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 1),
              child: Text(text, style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
}
