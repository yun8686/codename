import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename/model/Questions.dart';
import 'package:codename/model/WordSet.dart';
import 'package:codename/views/create/GameCreate.dart';
import 'package:codename/views/game/GameHero.dart';
import 'package:codename/views/game/GameView.dart';
import 'package:codename/model/Genre.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _homeTabState();
  }
}

class _homeTabState extends State<HomeWidget>with SingleTickerProviderStateMixin{
  static final Tab osusumeTab = const Tab(
    child: Text("おすすめ"),
  );
  List<Tab> tabs = [osusumeTab];
  List<Genre> genreList;

  @override
  void initState() {
    super.initState();
    Genre.getAll().then((List<Genre> genreList){
      if(this.mounted)setState(() {
        this.genreList = genreList;
        this.tabs = genreList.map((Genre genre) {
          return Tab(
              child: Text(genre.name),
          );
        }).toList();
        this.tabs.insert(0, osusumeTab);
        this.genreList.insert(0, Genre(name: "おすすめ", id: "popular"));
        this._tabController = TabController(length: this.tabs.length, vsync: this);
        this._selectTabIndex = this._tabController.index;
        this._selectGenre = this.genreList[this._selectTabIndex].id;

        this._tabController.addListener((){
          if(this.mounted)setState(() {
            this._selectTabIndex = this._tabController.index;
            this._selectGenre = this.genreList[this._selectTabIndex].id;
          });
        });
      });
    });
  }

  TabController _tabController;
  int _selectTabIndex = 0;
  String _selectGenre="";

  @override
  Widget build(BuildContext context) {
    if(this.genreList == null) return Text("ロード中");
    return DefaultTabController(
      // タブの数
      length: this.tabs.length??0,
      child: Scaffold(
        floatingActionButton: _selectTabIndex>0?QuestionCreateButton(_selectTabIndex):null,
        appBar: AppBar(
          bottom: TabBar(
            // タブのオプション
            controller: _tabController,
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            unselectedLabelStyle: TextStyle(fontSize: 12.0),
            labelColor: Colors.yellowAccent,
            labelStyle: TextStyle(fontSize: 16.0),
            indicatorColor: Colors.white,
            indicatorWeight: 2.0,
            // タブに表示する内容
            tabs: this.tabs??[],
          ),
          title: const Text('FindMembers'),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          // 各タブの内容
          children: genreList.map((Genre genre){
            return QuestionListWidget(genre: genre.id);
          }).toList(),
        ),
      ),
    );
  }


  Widget QuestionCreateButton(int index){
    return FloatingActionButton.extended(
      label: Text("問題作成"),
      onPressed: (){
        print("_selectGenre:" + _selectGenre);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameCreate(genre: _selectGenre,),
            )
        );
      },
    );
  }

}


class QuestionListWidget extends StatefulWidget {
  String genre;
  QuestionListWidget({Key key, this.genre}) : super(key: key);
  _QuestionListState createState() => _QuestionListState(genre: genre);
}

class _QuestionListState extends State<StatefulWidget> {
  _QuestionListState({String genre}){
    if(genre == "popular") genre = "animal";
    Question.getQuestionList(genre: genre).then((List<Question> questionList) {
      if(this.mounted)setState(() {
        this.questionList = questionList;
      });
    });

  }
  List<Question> questionList = List<Question>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: this.questionList.length>0?this.questionList.map((Question question){
          return Container(
              width: double.infinity,
              height: 100.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => GameView(question: question),
                      )
                  );
                },
                child: GameHero.createTitleCard(question),
              )
          );
        }).toList():[Text("ロード中")],
      ),
    );
  }
}
