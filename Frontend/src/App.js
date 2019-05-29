import React from 'react';
import './App.css';
import Services from './Services';
import Customers from './Customers';
import Devices from './Devices';
import {BrowserRouter as Router} from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import Route from 'react-router-dom/Route';
import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHome, faCopy, faUserFriends, faSignal, faDigitalTachograph, faTrash, faPlus} from '@fortawesome/free-solid-svg-icons';
library.add(faHome, faCopy, faUserFriends, faSignal, faDigitalTachograph, faTrash, faPlus );


function App() {
  return (
    <Router>
      <div className="App">
        <div id="navbar">
          {
            window.innerWidth>600 && <div className="navbar-max nav">

              <a href="/"><h3>Company Name</h3></a><br/>
              <a href="/"><FontAwesomeIcon className="icon" icon="home" />&nbsp;Home</a><br/>
              <a href="/services"><FontAwesomeIcon className="icon" icon="signal" />Services</a><br/>
              <a href="/devices"><FontAwesomeIcon className="icon" icon="digital-tachograph" />Devices</a><br/>
              <a href="/customers"><FontAwesomeIcon className="icon" icon="user-friends" />Customers</a><br/>
              <div style={{padding:"100px"}}></div>
            </div>
          }
          {
            window.innerWidth<600 && <div className="navbar-min nav">
              <a href="/"><FontAwesomeIcon className="icon" icon="home" /></a><br/>
              <a href="/services"><FontAwesomeIcon className="icon" icon="signal" /></a><br/>
              <a href="/devices"><FontAwesomeIcon className="icon" icon="digital-tachograph" /></a><br/>
              <a href="/customers"><FontAwesomeIcon className="icon" icon="user-friends" /></a><br/>
              <div style={{padding:"100px"}}></div>
            </div>
          }
        </div>
        <Route path="/" exact strict render={()=>{return(<h1>Home</h1>)}} />
        <Route path="/services" exact strict component={Services} />
        <Route path="/devices" exact strict component={Devices} />
        <Route path="/customers" exact strict component={Customers} />

      </div>
    </Router>
  );
}

export default App;
