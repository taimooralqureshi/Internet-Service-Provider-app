import React from 'react';
import Navbar from './Navbar'
import 'bootstrap/dist/css/bootstrap.min.css';
import { library } from '@fortawesome/fontawesome-svg-core';
import { faHome, faCopy, faUserFriends, faSignal, faDigitalTachograph, faTrash, faPlus, faEdit} from '@fortawesome/free-solid-svg-icons';
library.add(faHome, faCopy, faUserFriends, faSignal, faDigitalTachograph, faTrash, faPlus, faEdit );


function App() {
  return(<Navbar />);
}

export default App;
