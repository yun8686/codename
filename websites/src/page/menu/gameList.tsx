import * as React from 'react'
import '../../scss/app.scss'
import firebase from '../../firebase/firebase'


// typeScriptの場合は「interface」でState管理している
interface setState {
  word: string;
  gameList: {title: string, id: string}[];
}

class GameList extends React.Component {
  public componentDidMount(){
    return this.getData();
  }

  // stateを入れる
  public state: setState = {
    word: '質問',
    gameList: [],
  }

  // stateを入れる
  public async getData() {
    var database = firebase.firestore();
    var querySnapshot = await database.collection("questions").get();
    const gameList:{title: string, id: string}[] = [];
    querySnapshot.forEach((doc) => {
      const id = doc.id;
      const title:string = doc.data().title;
      gameList.push({title, id});
    });
    this.setState({gameList: gameList});
  }

  public orderWord(){

  }

  public rendringWord(){

  }

  public render() {
    return (
      <div className="driver">
        <h1>ゲームリスト</h1>
        <span>
        <ul className="wordList">
          {this.state.gameList.map(x => (<li key={x.id}><a href={"/gameData/"+x.id}>{x.title}</a></li>))}
        </ul>
        </span>
      </div>
    );
  }
}
export default GameList
