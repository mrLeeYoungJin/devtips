/* eslint-disable import/default */

import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from 'config/configureStore';
import { setupAxiosInterceptors } from 'rest/axios';
import { redirectToLoginWithMessage, logout} from 'reducers/authentication';
import { bindActionCreators } from 'redux';
import { Provider } from 'react-redux';
import { syncHistoryWithStore } from 'react-router-redux'
import { BrowserRouter as Router } from 'react-router-dom'
import createBrowserHistory from 'router/history'
import getRoutes from 'router/router';

import 'semantic-ui-css/semantic.css'
import 'css/index.scss'

const store = configureStore();
const history = syncHistoryWithStore(createBrowserHistory, store);
const actions = bindActionCreators({redirectToLoginWithMessage, logout}, store.dispatch);
setupAxiosInterceptors(() => actions.redirectToLoginWithMessage('login.error.unauthorized'));

ReactDOM.render(
  <Provider store={store}>
      <Router history={history} >
        {getRoutes()}
      </Router>
  </Provider>,
  document.getElementById('app')
);
