import 'package:auto_size_text/auto_size_text.dart';
import 'package:codename/model/Questions.dart';
import 'package:flutter/material.dart';

class GameHero{
  static Card createTitleCard(Question question){
    return Card(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: AutoSizeText(
                question.title,
                maxLines: 1,
                style: TextStyle(fontSize: 32.0, color: Colors.black),
              ),
            ),
            Row(
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
                      Text("たかしくん",style: TextStyle(color: Colors.grey)),
                      Icon(Icons.person, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}