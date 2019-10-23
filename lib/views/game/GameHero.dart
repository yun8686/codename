import 'package:codename/model/Questions.dart';
import 'package:flutter/material.dart';

class GameHero{
  static Card createTitleCard(Question question){
    return Card(
      child: Column(
        children: <Widget>[
          Text(
            question.title,
            style: TextStyle(fontSize: 40),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Row(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.thumb_up),
                    SizedBox(
                      width: 50.0,
                      child: Text("100"),
                    ),
                    Icon(Icons.remove_red_eye),
                    SizedBox(
                      width: 50.0,
                      child: Text("100"),
                    ),
                  ],
                ),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("たかしくん"),
                        Icon(Icons.person),
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