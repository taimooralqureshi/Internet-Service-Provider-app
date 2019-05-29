import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Customers extends Component{
    constructor(props){
      super(props);
      this.state={
        customers:[],
        name:'', contact:'', address:'', sub:'', device:'', err:'', sno:1,
        showPopup:false
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

    change = e => {
      this.setState({
        [e.target.name]: e.target.value
      });
    };

    add = states => {
      let row = this.state.customers;
      if(states.name==='' || states.contact==='' || states.address==='' || states.sub==='' || states.device===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else{
        row.push([states.sno++, states.name, states.contact, states.address, states.sub, states.device]);
        this.setState({
          customers : row,
          name : '',
          contact : '',
          address : '',
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
          //display service table
        }
        <Table bordered size="sm"  style={{textAlign:"left"}}>
          <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841"}}>
            <tr>
              <th>Customer Id</th>
              <th>Name</th>
              <th>Contact</th>
              <th>Address</th>
              <th>Subscription Details</th>
              <th>Device Details</th>
              <th>Remove</th>
            </tr>
          </thead>
          <tbody>
          {
              this.state.customers.map((item, i) => (
              <tr key={i}>
                <td>{this.state.customers[i]['id']}</td>
                <td>{this.state.customers[i]['name']}</td>
                <td>{this.state.customers[i]['contact']}</td>
                <td>{this.state.customers[i][3]}</td>
                <td>{this.state.customers[i]['subscription']}</td>
                <td>{this.state.customers[i][5]}</td>
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.customers) }
                  }>
                  <FontAwesomeIcon className="icon" icon="trash" /></a></td>
              </tr>
              ))
            }
          </tbody>
        </Table>

        {
          //add button popup
        }
        <Modal size="xl" show={this.state.showPopup} onHide={this.handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>Add Customer</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Table bordered size="sm">
              <thead  style={{color:"white", backgroundColor:"#ec9841"}}>
                <tr>
                  <th>Name</th>
                  <th>Contact</th>
                  <th>Address</th>
                  <th>Subscription Id</th>
                  <th>Device Id</th>
                </tr>
              </thead>
              <tbody>
                {
                  //input data
                }
                <tr>
                  <td><input type="text" name="name" value={this.state.name} onChange={e => this.change(e)}/></td>
                  <td><input type="text" name="contact" value={this.state.contact} onChange={e => this.change(e)}/></td>
                  <td><input type="text" name="address" value={this.state.address} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="sub" value={this.state.sub} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="device" value={this.state.device} onChange={e => this.change(e)}/></td>
                </tr>
              </tbody>
            </Table>
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
