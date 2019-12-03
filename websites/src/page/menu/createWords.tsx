import * as React from 'react'
import '../../scss/app.scss'
import kuromoji from "kuromoji"

const KuromojiBuilder = kuromoji.builder({ dicPath: "/dict" });

// typeScriptの場合は「interface」でState管理している
interface setState {
  input_text: string;
  wordList: string[];
}

class CreateWords extends React.Component {
  constructor(props: any) {
    super(props);
    this.state = {
      input_text: '',
      wordList: [],
    };

    this.textChange = this.textChange.bind(this);
    this.runKuromoji = this.runKuromoji.bind(this);
  }
  public componentDidMount(){
  }

  public textChange(event: any) {
    this.setState({input_text: event.target.value});
  }
  public runKuromoji(event: any) {
    const text = this.state.input_text;
    if(text) KuromojiBuilder.build((err, tokenizer) => {
      if(err){
        console.log(err)
      } else {
        const tokens = tokenizer.tokenize(text).filter( v=>v.pos==='名詞' && v.pos_detail_1==="一般");
        console.log(tokens);
        let list:string[] = [];
        tokens.forEach(w=>{
          list.push(w.surface_form);
        });
        list = list.filter((a,b,c)=>{return c.indexOf(a)===b;});
        this.setState({
          wordList: list,
        });
      }
    });
  }
  // stateを入れる
  public state: setState = {
    input_text: '',
    wordList: [],
  }

  public render() {
    return (
      <div className="driver">
        <h1>言葉作成画面</h1>
        <div>
          <textarea value={this.state.input_text} onChange={this.textChange} />
          <button onClick={this.runKuromoji}>作成</button>
        </div>
        <ul className="wordList">
          {
            this.state.wordList.map(x => (<li>{x}</li>))
            }
        </ul>
      </div>
    );
  }
}
export default CreateWords
