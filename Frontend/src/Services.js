import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Services extends Component{
    constructor(props){
      super(props);
      this.state={
        packages:[],
        validity:'', volume:'', speed:'', price:'', type:'', payment:'', err:'', sno:1,
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
      let row = this.state.packages;
      if(states.validity==='' || states.volume==='' || states.speed==='' || states.price==='' || states.type==='' || states.payment===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else{
        row.push([states.sno++, states.validity, states.volume, states.speed, states.price, states.type, states.payment]);
        this.setState({
          packages : row,
          validity : '',
          volume : '',
          speed : '',
          price : '',
          type : '',
          payment : '',
          err: ''
        });
      }
    };

    //rows: array from which element is to be deleted
    delete = (index, rows) => {
      let row = rows;
      row.splice(index,1);
      let count=1;
      {row.map((item, i) => (
        row[i][0]=count++
      ))}
      this.setState({
        packages  : row,
        sno : this.state.sno-1
      });
    };

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
              <th>Service Id</th>
              <th>Validity</th>
              <th>Volume</th>
              <th>Speed</th>
              <th>Price</th>
              <th>Type</th>
              <th>Payment</th>
              <th>Remove</th>
            </tr>
          </thead>
          <tbody>
            {
              this.state.packages.map((item, i) => (
              <tr key={i}>
                <td>{this.state.packages[i]['id']}</td>
                <td>{this.state.packages[i]['validity']}</td>
                <td>{this.state.packages[i]['data']}</td>
                <td>{this.state.packages[i]["speed"]}</td>
                <td>{this.state.packages[i]['price']}</td>
                <td>{this.state.packages[i]['type']}</td>
                <td>{this.state.packages[i][6]}</td>
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.packages) }
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
            <Modal.Title>Add Service</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Table bordered size="sm">
              <thead  style={{color:"white", backgroundColor:"#ec9841"}}>
                <tr>
                  <th>Validity</th>
                  <th>Volume</th>
                  <th>Speed</th>
                  <th>Price</th>
                  <th>Type</th>
                  <th>Payment</th>
                </tr>
              </thead>
              <tbody>
                {
                  //input data
                }
                <tr>
                  <td><input type="text" name="validity" value={this.state.validity} onChange={e => this.change(e)}/></td>
                  <td><input type="text" name="volume" value={this.state.volume} onChange={e => this.change(e)}/></td>
                  <td><input type="text" name="speed" value={this.state.speed} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="price" value={this.state.price} onChange={e => this.change(e)}/></td>
                  <td><select name="type" value={this.state.type} onChange={e => this.change(e)}>
                    <option>Select</option>
                    <option>Data</option>
                    <option>Broadband</option>
                  </select></td>
                  <td><select name="payment" value={this.state.payment} onChange={e => this.change(e)}>
                    <option>Select</option>
                    <option>Prepaid</option>
                    <option>Postpaid</option>
                  </select></td>
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

export default Services;
