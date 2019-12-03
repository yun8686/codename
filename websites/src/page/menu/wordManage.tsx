import * as React from 'react'
import '../../scss/app.scss'
import firebase from '../../firebase/firebase'


// typeScriptの場合は「interface」でState管理している
interface setState {
  word: string;
  wordList: [],
}

class WordManage extends React.Component {
  public componentDidMount(){
    return this.getData();
  }

  // stateを入れる
  public state: setState = {
    word: '質問',
    wordList: [],
  }

  // stateを入れる
  public async getData() {
    var database = firebase.firestore();
    var querySnapshot = await database.collection("wordset").get();
    querySnapshot.forEach((doc) => {

      console.log(doc.id, '=>', doc.data());
      console.log(doc.data().words)
      var wordList = doc.data().words;
      wordList.forEach((word:any) =>{
        this.setState({
          wordList: this.state.wordList.concat(word)
        });
      })

    });
  }

  public orderWord(){

  }

  public rendringWord(){

  }

  public render() {
    console.log(this.state.wordList);
    return (
      <div className="driver">
        <h1>管理画面</h1>
        <span>
        <ul className="wordList">
          {
            this.state.wordList.map(x => (<li>{x}</li>))
            }
        </ul>
        </span>
      </div>
    );
  }
}
export default WordManage
