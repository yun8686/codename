import * as React from 'react'
import '../../scss/app.scss'
import kuromoji from "kuromoji"
import firebase from '../../firebase/firebase'
import admin from 'firebase/app';


const database = firebase.firestore();
const animalRef = database.collection('wordset').doc('animal');
const KuromojiBuilder = kuromoji.builder({ dicPath: "/dict" });

// typeScriptの場合は「interface」でState管理している
interface setState {
  input_text: string;
  wordList: string[];
  nowList: string[];
}

class CreateWords extends React.Component {
  constructor(props: any) {
    super(props);
    this.state = {
      input_text: '',
      wordList: [],
      nowList: [],
    };

    this.textChange = this.textChange.bind(this);
    this.runKuromoji = this.runKuromoji.bind(this);
    this.addWord = this.addWord.bind(this);

  }
  public async componentDidMount(){
    const data = await animalRef.get();
    const dd:any = data.data();
    console.log(dd["words"]);
    this.setState({
      nowList: dd["words"],
    })
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
        console.log(tokenizer.tokenize(text));
        const tokens = tokenizer.tokenize(text).filter( v=>v.pos==='名詞' && (v.pos_detail_1==="固有名詞" || v.pos_detail_1==="一般"));
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

  public addWord(event: any){
    const word = event.currentTarget.getAttribute('data-value');
    if(word){
      animalRef.update({
        words: admin.firestore.FieldValue.arrayUnion(word)
      });
    }
  }
  // stateを入れる
  public state: setState = {
    input_text: '',
    wordList: [],
    nowList: []
  }

  public render() {
    return (
      <div className="driver">
        <h1>言葉作成画面</h1>
        <div>
          <textarea value={this.state.input_text} onChange={this.textChange} />
          {
            this.state.nowList.length>0 && (
              <button onClick={this.runKuromoji}>作成</button>
            )
          }
        </div>
        <ul className="wordList">
          {
            this.state.wordList.map(x => (
              <li key={x}><span>{x}</span><button data-value={x} onClick={this.addWord}>{x}</button></li>
            ))
            }
        </ul>
      </div>
    );
  }
}
export default CreateWords
