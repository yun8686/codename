import * as React from 'react'
import '../../scss/app.scss'
import firebase from '../../firebase/firebase'


// typeScriptの場合は「interface」でState管理している
interface setState {
  title: string;
  wordList: {name: string, answer: boolean}[];
}

class PlayGame extends React.Component {
  public componentDidMount(){
    return this.getQuestion();
  }

  // stateを入れる
  public state: setState = {
    title: '',
    wordList: [],
  }

  public async getQuestion() {
    const database = firebase.firestore();
    const counter = await database.collection("manageData").doc("counter").get();
    const counterData:any = counter.data();

    const playIdx = ~~(Math.random()*counterData.questions);
    console.log(playIdx);
    const results = await database.collection("questions").where("idx", ">=", playIdx).orderBy("idx").limit(1).get();
    results.forEach((doc)=>{
      const question = doc.data();
      this.setState({
        title: question.title,
        wordList: question.selections,
      })
    });


  }

  private clickWord(word: any){

  }

  public render() {
    return (
      <div className="driver">
        <h1>ゲームプレイ</h1>
        <h2>{this.state.title}</h2>
        <div style={({
          "display":"grid",
          "textAlign": "center",
          "verticalAlign": "middle",
          "gridTemplateRows":"100px 100px 100px 100px 100px",
          "gridTemplateColumns":"100px 100px 100px 100px 100px"
        })}>
          {this.state.wordList.map(
            word=>(
              <div style={{"padding": "auto", backgroundColor: word.answer?"green":"gray"}} key={word.name} onClick={()=>this.clickWord(word)}>{word.name}</div>
            )
          )}
        </div>
      </div>
    );
  }
}
export default PlayGame
