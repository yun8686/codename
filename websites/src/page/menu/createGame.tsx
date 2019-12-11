import * as React from 'react'
import '../../scss/app.scss'
import firebase from '../../firebase/firebase'


// typeScriptの場合は「interface」でState管理している
interface setState {
  title: string;
  wordList: {name: string, answer: boolean}[];
}

class CreateGame extends React.Component {
  public componentDidMount(){
    window.console.log('getData');
    return this.refleshWords();
  }

  // stateを入れる
  public state: setState = {
    title: '',
    wordList: [],
  }

  public async refleshWords(){
    const database = firebase.firestore();
    var querySnapshot = await database.collection("wordset").doc("animal").get();
    const words = (querySnapshot.data() as {words: string[]}).words;
    this.suffleSort(words);
    this.setState({
      wordList: words.filter((v,i)=>i<25).map(set=>{
        return {name: set, answer: false};
      }),
    });
    console.log(words);
  }
  public async createGame(){
    if(this.state.wordList.filter(v=>v.answer).length === 0
    || this.state.title === "" || !this.state.title){
      return;
    }
    const database = firebase.firestore();

    const batch = database.batch();
    const quetionRef = database.collection("questions").doc();
    const questionId = quetionRef.id;
    batch.set(quetionRef, {
      selections: this.state.wordList,
      title: this.state.title,
    });
    batch.update(database.collection("manageData").doc("counter"), {
      questions: firebase.firestore.FieldValue.increment(1),
      questionId: questionId,
    });
    await batch.commit();
    alert('作成しました');
  }

  private suffleSort(array: any[]){
    for(var i = array.length - 1; i > 0; i--){
        var r = Math.floor(Math.random() * (i + 1));
        var tmp = array[i];
        array[i] = array[r];
        array[r] = tmp;
    }
  }

  public clickWord(word: any){
    word.answer = !word.answer;
    this.setState({
    });
  }

  public render() {
    return (
      <div className="driver">
        <h1>ゲーム作成</h1>
        <button onClick={this.refleshWords.bind(this)}>Reflesh</button>
        <input value={this.state.title} onChange={(e)=>{this.setState({title: e.target.value});}} />
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
        <button onClick={this.createGame.bind(this)}>作成</button>
      </div>
    );
  }
}
export default CreateGame
