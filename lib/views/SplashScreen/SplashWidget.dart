import 'package:codename/main.dart';
import 'package:codename/model/MyData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatefulWidget {

  SplashWidget({Key key}) : super(key: key);
  @override
  _SplashWidgetState createState() => _SplashWidgetState();



}

class _SplashWidgetState extends State<SplashWidget> {
  Widget afterWidget;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setNotification().then((instance_id)async{
      Mydata mydata = await Mydata.getMyData();
      print(mydata);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => MainPage(),
      ));
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    );
  }


  // 通知設定
  Future<String> setNotification()async{
    FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
    await _firebaseMessaging.requestNotificationPermissions();
    await _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
//      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    return await _firebaseMessaging.getToken();
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];

    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
    return Future<void>.value();
  }


}