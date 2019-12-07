import 'package:flutter/material.dart';
import 'package:codename/views/Challenge/Challenge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                    button(
                      buttonText: "挑戦する",
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).push(
                          new MaterialPageRoute<Null>(
                            settings: const RouteSettings(name: "/Challenge"),
                            builder: (BuildContext context) => Challenge(/* 必要なパラメータがあればここで渡す */),
                          ),
                        );
                      },
                    ),
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
    Function onPressed ,
  }) {
    return RaisedButton(
      onPressed: onPressed??(){},
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