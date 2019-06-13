import React, { Component } from 'react';
import CustomerTimeGraph from './CustomerTimeGraph';
import DeviceTimeGraph from './DeviceTimeGraph';
import ServicesTimeGraph from './ServicesTimeGraph';

  class Home extends Component{
    render(){
      return(
      <div className="pageMargin">
        <CustomerTimeGraph/>
        <ServicesTimeGraph/>
        <DeviceTimeGraph/>
      </div>
    );
  }
}

export default Home;
