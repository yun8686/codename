import * as React from 'react'
import '../../scss/app.scss'
import firebase from '../../firebase/firebase'


// typeScriptの場合は「interface」でState管理している
interface setState {
  id: string;
  title: string;
  selections: {name: string, answer: boolean}[];
}

class GameList extends React.Component {
  public componentDidMount(){
    return this.getData((this.props as any).match.params);
  }

  // stateを入れる
  public state: setState = {
    id: '',
    title: '',
    selections: [],
  }

  // stateを入れる
  public async getData(params: any) {
    const id = params.id;
    var database = firebase.firestore();
    var querySnapshot = await database.collection("questions").doc(id).get();
    if(querySnapshot.exists){
      const data = querySnapshot.data();
      if(data){
        this.setState({
          title: data.title,
          selections: data.selections,
        });
      }
    }
  }

  public orderWord(){

  }

  public rendringWord(){

  }

  public render() {
    return (
      <div className="driver">
        <h1>{this.state.title}</h1>
        <span>
        <ul className="wordList">
          {
            this.state.selections.map(x => (<li key={x.name}>{x.name} <a>{x.answer.toString()}</a></li>))
            }
        </ul>
        </span>
      </div>
    );
  }
}
export default GameList
