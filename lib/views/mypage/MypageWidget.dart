import 'package:codename/model/Genre.dart';
import 'package:codename/model/MyData.dart';
import 'package:codename/views/create/GameCreate.dart';
import 'package:codename/views/mypage/MypageFooterWidget.dart';
import 'package:flutter/material.dart';

class MypageWidget extends StatefulWidget {
  MypageWidget();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MypageWidgetState();
  }
}

class _MypageWidgetState extends State<MypageWidget> {
  Mydata mydata;
  _MypageWidgetState(){
    Mydata.getMyData().then((Mydata mydata){
      setState(() {
        this.mydata = mydata;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size mediasize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: QuestionCreateButton(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              heightFactor: 1.6,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    "https://booth.pximg.net/c3d42cdb-5e97-43ff-9331-136453807f10/i/616814/d7def86b-1d95-4f2d-ad9c-c0c218e6a533_base_resized.jpg"),
              ),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Text(
                    this.mydata==null?"":this.mydata.name,
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: IconButton(
                    iconSize: 25.0,
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      return _editNameDialog(context);
                    },
                  ),
                ),
              ],
            ),
            MypageFooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget QuestionCreateButton() {
    return FloatingActionButton.extended(
      label: Text("問題作成"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameCreate(
                genre: "animal",
              ),
            ));
      },
    );
  }

  TextEditingController _textFieldController = TextEditingController();

  _editNameDialog(BuildContext context) async {
    _textFieldController = TextEditingController(text: this.mydata.name);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('名前を変更'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Input your name"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                setState(() {
                  this.mydata.name = _textFieldController.value.text;
                  Mydata.updateName(this.mydata);
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
  }
}
