import 'package:flutter/material.dart';

class MypageFooterWidget extends StatefulWidget{
  @override
  State<MypageFooterWidget> createState() {
    print("Mypage");
    // TODO: implement createState
    return _MypageFooterState();
  }
}

class _MypageFooterState extends State<MypageFooterWidget>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      new Tab(child: Text('Portfolio'),),
      new Tab(text: 'Skills'),
      new Tab(text: 'Articles'),
    ];
    _pages = [
      new Container(),
      new Container(),
      new Container(),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(fontSize: 12.0),
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 16.0),
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

}