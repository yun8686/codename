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
        onPressed: (){
          Navigator.of(context, rootNavigator: true).push(
            new MaterialPageRoute<Null>(
              settings: const RouteSettings(name: "/CreateQuestion"),
              builder: (BuildContext context) => CreateQuestion(/* 必要なパラメータがあればここで渡す */),
            ),
          );
        },
      ),
    );
  }
}

class _CreatedListArea extends StatefulWidget {
  _CreatedListState createState() =>_CreatedListState();
}

class _CreatedListState extends State<_CreatedListArea> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
        createListTile(),
      ],
    );
  }

  ListTile createListTile(){
    return ListTile(
      title: SizedBox(
        width: double.infinity,
        height: 100.0,
        child: Card(
          margin: EdgeInsets.all(0),
          child: InkWell(
            onTap: (){},
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Text(
                    "やどんを探せ",
                    style: TextStyle(fontSize: 30),
                  ),
                ],),
                Text("正解率 " + "10/100" + "人"),
                Text("コメント数 " + "10" + "コメント"),
              ],
            ),
          )
        ),
      ),
    );
  }
}