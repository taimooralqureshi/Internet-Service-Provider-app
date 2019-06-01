import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Customers extends Component{
    constructor(props){
      super(props);
      this.state={
        customers:[],
        name:'', contact:'', sub:'', device:'', err:'', sno:1,
        showPopup:false, subcriptionDetails:false, deviceDetails:false
      };
    }



    componentDidMount(){
      this.getServices();
      console.log(this.setState);

    }


      getServices = _ =>{
          fetch('http://localhost:4000/customers')
          .then(res => {
            console.log(res);
            return res.json()
         })
        .then(customers => {
            console.log(customers);
            this.setState({ customers: customers })
         })
          .catch(err => console.error(err));
      };









    handleClose=()=> {
      this.setState({ showPopup: false });
    }

    handleShow=()=> {
      this.setState({ showPopup: true });
    }

    closeSubscription=()=> {
      this.setState({ subscriptionDetails: false });
    }

    showSubscription=()=> {
      this.setState({ subscriptionDetails: true });
    }

    closeDevices=()=> {
      this.setState({ deviceDetails: false });
    }

    showDevices=()=> {
      this.setState({ deviceDetails: true });
    }

    change = e => {
      this.setState({
        [e.target.name]: e.target.value
      });
    };

    add = states => {
      let row = this.state.customers;
      if(states.name==='' || states.contact==='' || states.sub==='' || states.device===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else{
        row.push([states.sno++, states.name, states.contact, states.sub, states.device]);
        this.setState({
          customers : row,
          name : '',
          contact : '',
          sub : '',
          device : '',
          err: ''
        });
      }
    };

    //rows: array from which element is to be deleted
    delete = (index, rows) => {
      rows.splice(index,1);
    };

    render(){
      return(
      <div id="customers" className="pageMargin">
        <Button id="addBtn" onClick={this.handleShow}>Add</Button><br/>

        {
          //display customer table
        }
        <Table bordered size="sm"  style={{textAlign:"left"}}>
          <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841"}}>
            <tr>
              <th style={{width:"103px"}}>Customer Id</th>
              <th>Name</th>
              <th>Contact</th>
              <th>Subscription Details</th>
              <th>Device Details</th>
              <th style={{width:"50px"}}>Remove</th>
            </tr>
          </thead>
          <tbody>
          {
              this.state.customers.map((item, i) => (
              <tr key={i}>
                <td>{this.state.customers[i]['id']}</td>
                <td>{this.state.customers[i]['name']}</td>
                <td>{this.state.customers[i]['contact']}</td>
                <td><a href="#" onClick={this.showSubscription}>{this.state.customers[i]['s_name']}</a><br/></td>
                {
                  // Subscription Details model
                }
                <Modal size="sm" show={this.state.subcriptionDetails} onHide={this.closeSubscription}>
                  <Modal.Header closeButton>
                    <Modal.Title>{this.state.customers[i]['s_name']}</Modal.Title>
                  </Modal.Header>
                  <Modal.Body>
                    <div>{this.state.customers[i]['s_validity']}</div>
                    <div>{this.state.customers[i]['s_volume']}</div>
                    <div>{this.state.customers[i]['s_speed']}</div>
                    <div>{this.state.customers[i]['s_price']}</div>
                    <div>{this.state.customers[i]['s_type']}</div>
                  </Modal.Body>
                  <Modal.Footer>
                    <Button variant="secondary" onClick={this.closeSubscription}>Close</Button>
                  </Modal.Footer>
                </Modal>
                {
                    // {this.state.customers[i]['s_validity']}<br/>
                    // {this.state.customers[i]['s_volume']}<br/>
                    // {this.state.customers[i]['s_speed']}<br/>
                    // {this.state.customers[i]['s_price']}<br/>
                    // {this.state.customers[i]['s_type']}</td>
                }
                <td><a href="#" onClick={this.showDevices}>{this.state.customers[i]['d_name']}</a><br/></td>
                {
                  // Device Details model
                }
                <Modal size="sm" show={this.state.deviceDetails} onHide={this.closeDevices}>
                  <Modal.Header closeButton>
                    <Modal.Title>{this.state.customers[i]['d_name']}</Modal.Title>
                  </Modal.Header>
                  <Modal.Body>
                    <div>{this.state.customers[i]['d_description']}</div>
                    <div>{this.state.customers[i]['d_price']}</div>
                  </Modal.Body>
                  <Modal.Footer>
                    <Button variant="secondary" onClick={this.closeDevices}>Close</Button>
                  </Modal.Footer>
                </Modal>
                {
                    // {this.state.customers[i]['d_description']}<br/>
                    // {this.state.customers[i]['d_price']}</td>
                }
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.customers) }
                  }>
                  <FontAwesomeIcon className="icon" icon="trash" style={{marginLeft:"40%"}} /></a></td>
              </tr>
              ))
            }
          </tbody>
        </Table>



        {
          //add button popup
        }
        <Modal size="sm" show={this.state.showPopup} onHide={this.handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>Add Customer</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <label>Name</label>
            <td><input type="text" name="name" value={this.state.name} onChange={e => this.change(e)}/></td>
            <label>Contact</label>
            <td><input type="text" name="contact" value={this.state.contact} onChange={e => this.change(e)}/></td>
            <label>Subscription Id</label>
            <td><input type="number" name="sub" value={this.state.sub} onChange={e => this.change(e)}/></td>
            <label>Device Id</label>
            <td><input type="number" name="device" value={this.state.device} onChange={e => this.change(e)}/></td>
            </Modal.Body>
          <Modal.Footer>
            <span style={{color:"red"}}>{this.state.err}</span>
            <Button variant="secondary" onClick={this.handleClose}>Close</Button>
            <Button variant="primary" onClick={()=> this.add(this.state)}>Add</Button>
          </Modal.Footer>
        </Modal>
      </div>
    );
  }
}

export default Customers;
