import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Devices extends Component{
    constructor(props){
      super(props);
      this.state={
        devices:[],
        name:'', desc:'', price:'', err:'', sno:1,
        showPopup:false
      };
    }



    componentDidMount(){
      this.getDevices();
      console.log(this.setState);

    }


      getDevices = _ =>{
          fetch('http://localhost:4000/devices')
          .then(res => {
            console.log(res);
            return res.json()
         })
        .then(devices => {
            console.log(devices);
            this.setState({ devices: devices })
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
      let row = this.state.devices;
      if(states.name==='' || states.desc==='' || states.price===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else{
        row.push([states.sno++, states.name, states.desc, states.price]);
        this.setState({
          devices : row,
          name : '',
          desc : '',
          price : '',
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
      <div id="devices" className="pageMargin">
        <Button id="addBtn" onClick={this.handleShow}>Add</Button><br/>
        {
          //display devices table
        }
        <Table bordered size="sm"  style={{textAlign:"left"}}>
          <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841"}}>
            <tr>
              <th style={{width:"80px"}}>Device Id</th>
              <th>Name</th>
              <th>Description</th>
              <th>Price</th>
              <th style={{width:"50px"}}>Remove</th>
            </tr>
          </thead>
          <tbody>
            {
              this.state.devices.map((item, i) => (
              <tr key={i}>
                <td>{this.state.devices[i]['id']}</td>
                <td>{this.state.devices[i]['device']}</td>
                <td>{this.state.devices[i]['description']}</td>
                <td>Rs.{this.state.devices[i]['price']}</td>
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.devices) }
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
            <Modal.Title>Add Device</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <label>Name</label>
            <td><input type="text" name="name" value={this.state.name} onChange={e => this.change(e)}/></td>
            <label>Description</label>
            <td><input type="text" name="desc" value={this.state.desc} onChange={e => this.change(e)}/></td>
            <label>Price</label>
            <td><input type="number" name="price" value={this.state.price} onChange={e => this.change(e)}/></td>
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

export default Devices;
