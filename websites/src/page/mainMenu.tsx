import * as React from 'react'
import '../scss/app.scss'
import { Link } from 'react-router-dom'

// typeScriptの場合は「interface」でState管理している
interface setState {
  word: string;
  wordList: [],
}

class WordManage extends React.Component {
  public componentDidMount(){
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
        <h1 className="header">メインメニュー</h1>
        <span>
        <ul className="menu">
          <li className="menu-item"><Link to='/createWords'>言葉作成</Link></li>
          <li className="menu-item"><Link to='/wordManage'>言葉管理</Link></li>
          <li className="menu-item"><Link to='/gameList'>ゲームリスト</Link></li>
          <li className="menu-item"><Link to='/createGame'>ゲーム作成</Link></li>
        </ul>
        </span>
      </div>
    );
  }
}
export default WordManage
