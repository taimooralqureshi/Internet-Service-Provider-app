import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Devices extends Component{
    constructor(props){
      super(props);
      this.state={
        devices:[],
        name:'', desc:'', price:'', err:'', sno:1, device_id:1,
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

    deleteDevice = id =>{
      fetch('http://localhost:4000/devices/'+id,{method : 'DELETE'})
      .then(res => {
        this.getDevices();
        return res.json();
      })
      .catch(err => console.error(err));
    };

    addDevice = device =>
      {
        console.log(device);

        fetch('http://localhost:4000/devices/',{
          method : 'POST',
          headers: {'Content-Type':'application/json'},
          body : JSON.stringify(device)

      })
      .then(res => {
        this.getDevices();
        return res.json();
     })
     .catch(err => console.error(err));
    };

    editDevice = (device,id) =>
    {
      console.log(device);

      fetch('http://localhost:4000/devices/'+id,{
        method : 'PUT',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(device)
      })
      .then(res => {
        this.getDevices();
        return res.json();
     })
     .catch(err => console.error(err));
    };



    handleClose=()=> {
      this.setState({
        showPopup: false,
        name : '',
        desc : '',
        price : '',
        err: ''
      });
    }

    handleShow=()=> {
      this.setState({ showPopup: true });
    }

    editClose=()=> {
      this.setState({
        editPopup: false,
        name : '',
        desc : '',
        price : '',
        err: ''
      });
    }

    editShow=()=> {
      this.setState({ editPopup: true });
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
      else if(states.price<0){
        this.setState({
          err : 'price cannot be negative'
        });
      }
      else{
        //row.push([states.sno++, states.name, states.desc, states.price]);

        var custom_device = {
          "device": states.name,
          "price" : states.price,
          "description" : states.desc,
        }

        this.addDevice(custom_device);
        this.handleClose();
      }
    };

    edit = states => {
      if(states.name==='' || states.desc==='' || states.price===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else if(states.price<0){
        this.setState({
          err : 'price cannot be negative'
        });
      }
      else{
        //row.push([states.sno++, states.name, states.desc, states.price]);

        var custom_device = {
          "device": states.name,
          "price" : states.price,
          "description" : states.desc
        }

        this.editDevice(custom_device, states.device_id);
        this.editClose();
      }
    };

    //rows: array from which element is to be deleted
    delete = (index, rows, item) => {
      rows.splice(index,1);
      this.deleteDevice(item.id);
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
              <th style={{width:"100px"}}>Action</th>
            </tr>
          </thead>
          <tbody>
            {
              this.state.devices.map((item, i) => (
              <tr key={i}>
                <td>{i+1}</td>
                <td>{item.device}</td>
                <td>{item.description}</td>
                <td>Rs.{item.price}</td>
                <td>
                  <a href="#" onClick={() =>
                  {
                    this.setState({
                      name : item.device,
                      desc : item.description,
                      price : item.price,
                      device_id : item.id

                    });
                    this.editShow()
                  }
                  }>
                  <FontAwesomeIcon className="icon" icon="edit" style={{marginLeft:"20%", color:"blue"}} /></a>
                  <a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.devices, item) }
                  }>
                  <FontAwesomeIcon className="icon" icon="trash" style={{marginLeft:"20%", color:"red"}} /></a></td>
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
            <Button variant="primary" onClick={()=> this.add(this.state)}>OK</Button>
          </Modal.Footer>
        </Modal>

        {
          //edit button popup
        }
        <Modal size="sm" show={this.state.editPopup} onHide={this.editClose}>
          <Modal.Header closeButton>
            <Modal.Title>Edit Device</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <span><b>Name</b>:</span>  <span><td>{this.state.name}</td></span>
            <label>Description</label>
            <td><input type="text" name="desc" value={this.state.desc} onChange={e => this.change(e)}/></td>
            <label>Price</label>
            <td><input type="number" name="price" value={this.state.price} onChange={e => this.change(e)}/></td>
          </Modal.Body>
          <Modal.Footer>
            <span style={{color:"red"}}>{this.state.err}</span>
            <Button variant="secondary" onClick={this.editClose}>Close</Button>
            <Button variant="primary" onClick={()=> this.edit(this.state)}>OK</Button>
          </Modal.Footer>
        </Modal>
      </div>
    );
  }
}

export default Devices;
