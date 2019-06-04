import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Services extends Component{
    constructor(props){
      super(props);
      this.state={
        packages:[],
        name:'', validity:'', volume:'', speed:'', price:'', type:'', err:'', sno:1,
        showPopup:false
      };
    }

  componentDidMount(){
    this.getServices();
    console.log(this.setState);

  }


    getServices = _ =>{
        fetch('http://localhost:4000/services')
        .then(res => {
          console.log(res);
          return res.json()
       })
      .then(services => {
          console.log(services);
          this.setState({ packages: services })
       })
        .catch(err => console.error(err));
    };

    deleteService = id =>{
      fetch('http://localhost:4000/services/'+id,{method : 'DELETE'})
      .then(res => {
        return res.status(200);
      })
      .catch(err => console.error(err));
    };

    addService = service =>
    {
      console.log(service);

      fetch('http://localhost:4000/services/',{
        method : 'POST',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(service)
      })
      .then(res => {
        return res.json();
     })
     .catch(err => console.error(err));
    };

    editService = service =>
    {
      console.log(service);

      fetch('http://localhost:4000/services/',{
        method : 'PUT',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(service)
      })
      .then(res => {
        return res.json();
     })
     .catch(err => console.error(err));
    };


    handleClose=()=> {
      this.setState({ showPopup: false });
      this.setState({
        name : '',
        validity : '',
        volume : '',
        speed : '',
        price : '',
        type : '',
        err: ''
      });
    }

    handleShow=()=> {
      this.setState({ showPopup: true });
    }

    editClose=()=> {
      this.setState({ editPopup: false });
      this.setState({
        name : '',
        validity : '',
        volume : '',
        speed : '',
        price : '',
        type : '',
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
      let row = this.state.packages;
      if(states.name==='' || states.validity==='' || states.volume==='' || states.speed==='' || states.price==='' || states.type===''){
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
        row.push([states.sno++, states.name, states.validity, states.volume, states.speed, states.price, states.type]);

        var custom_service = {
          "service": states.name,
          "validity" : states.validity,
          "data" : states.volume,
          "speed" : states.speed,
          "price" : states.price,
          "type" : states.type,
        }

        this.addService(custom_service);
        this.handleClose();
      }
    };

    edit = states => {
      if(states.name==='' || states.validity==='' || states.volume==='' || states.speed==='' || states.price==='' || states.type===''){
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
        var custom_service = {
          "service": states.name,
          "validity" : states.validity,
          "data" : states.volume,
          "speed" : states.speed,
          "price" : states.price,
          "type" : states.type,
        }

        this.editService(custom_service);
        this.editClose();
      }
    };

    //rows: array from which element is to be deleted
    delete = (index, rows, item) => {
      rows.splice(index,1);
      this.deleteService(item.id);
    };

    modalBody = () => {
      return(
        <div>
          <label>Validity</label>
          <td><input type="text" name="validity" value={this.state.validity} onChange={e => this.change(e)}/></td>
          <label>Volume</label>
          <td><input type="text" name="volume" value={this.state.volume} onChange={e => this.change(e)}/></td>
          <label>Speed</label>
          <td><input type="text" name="speed" value={this.state.speed} onChange={e => this.change(e)}/></td>
          <label>Price</label>
          <td><input type="number" name="price" value={this.state.price} onChange={e => this.change(e)}/></td>
          <label>Type</label>
          <td><select style={{width:"180px", height:"30px"}} name="type" value={this.state.type} onChange={e => this.change(e)}>
            <option>Select</option>
            <option>Data</option>
            <option>Broadband</option>
          </select></td>
        </div>
      );
    }

    render(){
      return(

      <div id="services" className="pageMargin">
        <Button id="addBtn" onClick={this.handleShow}>Add</Button><br/>
        {
          //display service table
        }
        <Table bordered size="sm"  style={{textAlign:"left"}}>
          <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841"}}>
            <tr>
              <th style={{width:"85px"}}>Service Id</th>
              <th>Name</th>
              <th>Validity</th>
              <th>Volume</th>
              <th>Speed</th>
              <th>Price</th>
              <th>Type</th>
              <th style={{width:"100px"}}>Action</th>
            </tr>
          </thead>
          <tbody>
            {
              this.state.packages.map((item, i) => (
              <tr key={i}>
                <td>{this.state.packages[i]['id']}</td>
                <td>{this.state.packages[i]['service']}</td>
                <td>{this.state.packages[i]['validity']}</td>
                <td>{this.state.packages[i]['data']}</td>
                <td>{this.state.packages[i]["speed"]}</td>
                <td>{this.state.packages[i]['price']}</td>
                <td>{this.state.packages[i]['type']}</td>
                <td>
                  <a href="#" onClick={() =>
                  {
                    this.setState({
                      name : this.state.packages[i]['service'],
                      validity : this.state.packages[i]['validity'],
                      volume : this.state.packages[i]['data'],
                      speed : this.state.packages[i]['speed'],
                      price : this.state.packages[i]['price'],
                      type : this.state.packages[i]['type']
                    });
                    this.editShow()
                  }
                  }>
                  <FontAwesomeIcon className="icon" icon="edit" style={{marginLeft:"20%", color:"blue"}} /></a>
                  <a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.packages, item) }
                  }>
                  <FontAwesomeIcon className="icon" icon="trash" style={{marginLeft:"20%", color:"red"}} /></a>
                </td>
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
            <Modal.Title>Add Service</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <label>Name</label>
            <td><input type="text" name="name" value={this.state.name} onChange={e => this.change(e)}/></td>
            {this.modalBody()}
          </Modal.Body>
          <Modal.Footer>
            <span style={{color:"red"}}>{this.state.err}</span>
            <Button variant="secondary" onClick={this.handleClose}>Close</Button>
            <Button variant="primary" onClick={()=> this.add(this.state)}>Add</Button>
          </Modal.Footer>
        </Modal>

        {
          //edit button popup
        }
        <Modal size="sm" show={this.state.editPopup} onHide={this.editClose}>
          <Modal.Header closeButton>
            <Modal.Title>Edit Service</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <span><b>Name</b>:</span>  <span><td>{this.state.name}</td></span>
            {this.modalBody()}
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

export default Services;
