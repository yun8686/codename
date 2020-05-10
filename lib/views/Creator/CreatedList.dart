import 'package:codename/Model/Question.dart';
import 'package:codename/Provider/QuestionsProvider.dart';
import 'package:codename/views/Creator/CreateQuestion.dart';
import 'package:flutter/material.dart';

class CreatedList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("作成した問題")),
      body: SafeArea(
        child: Center(child: _CreatedListArea()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            new MaterialPageRoute<Null>(
              settings: const RouteSettings(name: "/CreateQuestion"),
              builder: (BuildContext context) =>
                  CreateQuestion(/* 必要なパラメータがあればここで渡す */),
            ),
          );
        },
      ),
    );
  }
}

class _CreatedListArea extends StatefulWidget {
  _CreatedListState createState() => _CreatedListState();
}

class _CreatedListState extends State<_CreatedListArea> {
  List<Question> questions = List<Question>();
  @override
  void initState() {
    super.initState();
    QuestionsProvider.getCreatedQuestions().then((questions) {
      setState(() {
        this.questions = questions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("questions.length: " + questions.length.toString());
    if (questions.length > 0) {
      return ListView(
        children: questions.map(createListTile).toList(),
      );
    } else {
      return Text("右下のボタンから問題を作成してください");
    }
  }

  ListTile createListTile(Question question) {
    return ListTile(
      title: SizedBox(
        width: double.infinity,
        height: 130.0,
        child: Card(
            child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Text(
                          question.title,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Text("正解率 " + "10/100" + "人"),
                Text("コメント数 " + "10" + "コメント"),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
