import 'dart:math';

import 'package:codename/model/Questions.dart';
import 'package:codename/views/game/GameView.dart';
import 'package:codename/views/main/HomeWidget.dart';
import 'package:codename/views/mypage/MypageWidget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindMembers'),
        centerTitle: true,
      ),
      body: getPageWidget(_selectedIndex),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            title: new Text('Mypage'),
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.lightBlueAccent,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getPageWidget(int idx){
    switch(idx){
      case 1:
        return MypageWidget();
      case 0:
        return HomeWidget();
    }
    return HomeWidget();
  }
}