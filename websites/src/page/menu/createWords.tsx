import * as React from 'react'
import '../../scss/app.scss'
import kuromoji from '../../modules/keitaiso.js'

// typeScriptの場合は「interface」でState管理している
interface setState {
  word: string;
  wordList: [],
}

interface Keitaiso {
  pos: string,
  pos_detail_1: string,
}

class WordManage extends React.Component {
  public componentDidMount(){
    var list = kuromoji(
        `今日はクマを見て楽しかった。`
      , (v: Keitaiso)=>{
        return v.pos==='名詞' && v.pos_detail_1==="一般";
      }
    );
    console.log(list);
  }

  // stateを入れる
  public state: setState = {
    word: '質問',
    wordList: [],
  }

  public render() {
    console.log(this.state.wordList);
    return (
      <div className="driver">
        <h1>言葉作成画面</h1>
        <span>
        <ul className="wordList">
        </ul>
        </span>
      </div>
    );
  }
}
export default WordManage
