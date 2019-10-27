import 'package:codename/model/Questions.dart';
import 'package:flutter/material.dart';

class GameHero{
  static Card createTitleCard(Question question){
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                question.title,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0),
            child: Row(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.thumb_up,color: Colors.grey),
                    SizedBox(
                      width: 50.0,
                      child: Text("100",style:TextStyle(color: Colors.grey)),
                    ),
                    Icon(Icons.flag, color: Colors.red,),
                    SizedBox(
                      width: 50.0,
                      child: Text("34%",style:TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("たかしくん",style:TextStyle(color: Colors.grey)),
                        Icon(Icons.person, color: Colors.grey),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}