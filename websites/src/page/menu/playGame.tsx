import * as React from 'react'
import '../../scss/app.scss'
import firebase from '../../firebase/firebase'


// typeScriptの場合は「interface」でState管理している
interface setState {
  title: string;
  selections: {name: string, answer: boolean}[];
  select: boolean[];
  checknum: number;
  answernum: number;
}

class PlayGame extends React.Component {
  public componentDidMount(){
    return this.getQuestion();
  }

  // stateを入れる
  public state: setState = {
    title: '',
    selections: [],
    select: [],
    checknum: 0,
    answernum: 0,
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
        selections: question.selections,
        select: question.selections.map(()=>false),
        checknum: 0,
        answernum: question.selections.filter((v: any)=>v.answer).length
      })
    });


  }

  private clickWord(idx: number){
    const select = this.state.select.map((v,i)=>i===idx?true:v);
    this.setState({
      select: select,
      checknum: select.filter((v, i)=>v&&this.state.selections[i].answer).length,
    });
  }

  public render() {
    return (
      <div className="driver">
        <h1>ゲームプレイ</h1>
        <p>{this.state.title}</p>
        <p>{this.state.checknum} / {this.state.answernum}</p>
        <div style={({
          "display":"grid",
          "textAlign": "center",
          "verticalAlign": "middle",
          "gridTemplateRows":"100px 100px 100px 100px 100px",
          "gridTemplateColumns":"100px 100px 100px 100px 100px"
        })}>
          {this.state.selections.map(
            (word, i)=>(
              <div style={{"padding": "auto", backgroundColor: this.state.select[i]?(word.answer?"green":"red"):"white"}} key={word.name} onClick={()=>this.clickWord(i)}>{word.name}</div>
            )
          )}
        </div>
      </div>
    );
  }
}
export default PlayGame
