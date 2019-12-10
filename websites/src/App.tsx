import * as React from 'react';
import './scss/app.scss';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

import CreateWords from './page/menu/createWords';
import wordManage from './page/menu/wordManage';
import gameList from './page/menu/gameList';
import gameData from './page/menu/gameData';
import createGame from './page/menu/createGame';
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
          <Route exact={true} path="/gameList" component={gameList} />
          <Route exact={true} path="/gameData/:id" component={gameData} />
          <Route exact={true} path="/createGame" component={createGame} />

        </Switch>
      </BrowserRouter>
    );
  }
}
export default App
