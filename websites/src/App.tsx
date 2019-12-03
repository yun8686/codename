import * as React from 'react';
import './scss/app.scss';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

import CreateWords from './page/menu/createWords';
import wordManage from './page/menu/wordManage';
import mainMenu from './page/mainMenu';

// typeScriptの場合は「interface」でState管理している
interface setState {
  word: string;
  wordList: [],
}

class App extends React.Component {
  public render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact={true} path='/' component={mainMenu} />
          <Route exact={true} path='/createWords' component={CreateWords} />
          <Route exact={true} path="/wordManage" component={wordManage} />
        </Switch>
      </BrowserRouter>
    );
  }
}
export default App
