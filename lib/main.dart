import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 200,),
                    Text("Code Name"),
                    SizedBox(height: 100,),
                    button(buttonText: "挑戦する"),
                    SizedBox(height: 30,),
                    button(buttonText: "問題を編集"),
                    SizedBox(height: 30,),
                    button(buttonText: "マイページ"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton button({
    String buttonText,
  }) {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(buttonText),
        width: 300,
      ),
    );
  }
}
