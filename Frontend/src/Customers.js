import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class Customers extends Component{
    constructor(props){
      super(props);
      this.state={
        customers:[],
        name:'', contact:'', sub:'', device:'', err:'', sno:1, detail: {},
        showPopup:false, showDetails:false, deviceDetails:false
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

    closeDetails=()=> {
      this.setState({ showDetails: false });
      detail : {}
    }

    showDetails=(item)=> {
      this.setState({
        showDetails: true,
        detail :item,
        deviceDetails :  item.d_name !== null
      });
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
        <div>
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
                <th style={{width:"50px"}}>Remove</th>
              </tr>
            </thead>
            <tbody>
            {
              this.state.customers.map((item, i) => (
              <tr onClick={() => this.showDetails(item)} key={i}>
                <td>{item.id}</td>
                <td>{item.name}</td>
                <td>{item.contact}</td>
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.customers) }
                  }>
                  <FontAwesomeIcon className="icon" icon="trash" style={{marginLeft:"40%"}} /></a>
                </td>
              </tr>
              ))
            }
            </tbody>
          </Table>


          {
            //details popup
          }
          <Modal size="lg" show={this.state.showDetails} onHide={this.closeDetails}>
            <Modal.Body style={{padding:"30px 50px"}} className="detailsModal">
              <div id="detailModalHeading">{this.state.detail['name']}</div>
              <div><span>Contact : </span>{this.state.detail['contact']}</div>
              <hr style={{color:"#ec9941", marginTop:"20px"}}/>
              <div id="detailModalSubHeading">Subscription Details</div>
              <div><span>Subscription Name : </span>{this.state.detail['s_name']}</div>
              <div><span>Type : </span>{this.state.detail['s_type']}</div>
              <div><span>Validity : </span>{this.state.detail['s_validity']}</div>
              <div><span>Volume Usage : </span>{this.state.detail['s_volume']}</div>
              <div><span>Speed Upto : </span>{this.state.detail['s_speed']}</div>
              <div><span>Flat Price : </span>{this.state.detail['s_price']}Rs</div>
              <hr style={{color:"#ec9941", marginTop:"20px"}}/>
              <div id="detailModalSubHeading">Device Details</div>
    
              {this.state.deviceDetails && <div><span>Device Name : </span>{this.state.detail['d_name']}</div>}
              {this.state.deviceDetails && <div><span>Description : </span>{this.state.detail['d_description']}</div>}
              {this.state.deviceDetails && <div><span>Price : </span>{this.state.detail['d_price']}Rs.</div>}
              {!this.state.deviceDetails && <div><span>No Device Bought</span></div>}
            </Modal.Body>
            <Modal.Footer>
              <Button variant="secondary" onClick={this.closeDetails}>Close</Button>
            </Modal.Footer>
          </Modal>


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
      </div>
    );
  }
}

export default Customers;
