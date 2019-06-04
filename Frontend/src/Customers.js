import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

   Date.prototype.addDays = function(days) {
      var date = new Date(this.valueOf());
      date.setTime(date.getTime() + days* 24 * 60 * 60 * 1000);
      return date;
    }
    Date.prototype.addMonths = function (m) {
      var d = new Date(this);
      var years = Math.floor(m / 12);
      var months = m - (years * 12);
      if (years) d.setFullYear(d.getFullYear() + years);
      if (months) d.setMonth(d.getMonth() + months);
      return d;
  }

  class Customers extends Component{
    constructor(props){
      super(props);
      this.state={
        customers:[], devices:[], services:[],
        name:'', contact:'', address:'', sub:'', device:'', err:'', sno:1, detail: {},
        showPopup:false, showDetails:false, deviceDetails:true
      };
    }




    componentDidMount(){
      this.getCustomers();
      this.getDevices();
      this.getServices();
    }

    getCustomers = _ =>{
        fetch('http://localhost:4000/customers')
        .then(res => {
          return res.json()
       })
      .then(customers => {
          this.setState({ customers: customers })
       })
        .catch(err => console.error(err));
    };

    getDevices = _ =>{
        fetch('http://localhost:4000/devices')
        .then(res => {
          return res.json()
       })
      .then(devices => {
          this.setState({ devices: devices })
       })
        .catch(err => console.error(err));
    };

    getServices = _ =>{
        fetch('http://localhost:4000/services')
        .then(res => {
          return res.json()
       })
      .then(services => {
          this.setState({ services: services })
       })
        .catch(err => console.error(err));
    };


    deleteCustomer = id =>{
      fetch('http://localhost:4000/customers/'+id,{method : 'DELETE'})
      .then(res => {
        return res.status(200);
     })
    .catch(err => console.error(err));
  };

  addCustomer = customer =>
    {
      console.log(customer);

      fetch('http://localhost:4000/customers/',{
        method : 'POST',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(customer)

    })
    .then(res => {
      return res.json();
   })
   .catch(err => console.error(err));
  };

    expiryDateAndStatusUpdate=(item)=> {
     let date = new Date(item.active_date)
      // let expiryDate = "UnKnown Activation Date";

      // if (item.s_validity.toLowerCase().search('month') !== -1)
      //      expiryDate = date.addMonths(item.s_validity.split(' ')[0]);
      // else if (item.s_validity.toLowerCase().search('day') !== -1)
      //      expiryDate = date.addDays(item.s_validity.split(' ')[0]);

      //   item['exp'] = expiryDate;
      // if(expiryDate >= Date.now())
      //     item.status = "Active";
      //   else
      //   item.status = "Deactive";

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
        deviceDetails : item.d_name !== null
      });
    }


    change = e => {
      this.setState({
        [e.target.name]: e.target.value
      });
    };

    findServiceId = name => {
      for(let i=0; i<this.state.services.length; i++){
        if(this.state.services['service']==name)
          return this.state.services['id'];
      }
    };

    findDeviceId = name => {
      for(let i=0; i<this.state.devices.length; i++){
        if(this.state.devices['device']==name)
          return this.state.devices['id'];
      }
    };

    add = states => {
      let row = this.state.customers;
      if(states.name==='' || states.contact==='' || states.address==='' || states.sub==='' || states.device===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else{
        states.sub=this.findServiceId(states.sub);
        states.device=this.findDeviceId(states.device);
        row.push([states.sno++, states.name, states.contact, states.address, states.sub, states.device]);

        var custom_customer = {
          "name": states.name,
          "contact" : states.contact,
          "address" : states.address,
          "service_id" : states.sub,
          "device_id" : states.device,
          "active_date" : (new Date()).toJSON().slice(0,10).split('-').join('/')
        }

        this.setState({
          customers : row,
          name : '',
          contact : '',
          address : '',
          sub : '',
          device : '',
          err: ''
        });

        {
        //   var custom_customer = {
        //   "name": "Taimoor Qureshi",
        //   "contact" : "0348-464-2025",
        //   "service_id" : 5,
        //   "device_id" : 5,
        //   "active_date" : (new Date()).toJSON().slice(0,10).split('-').join('/')
        // }
        }

        this.addCustomer(custom_customer);
      }
    };

    //rows: array from which element is to be deleted
    delete = (index, rows,item) => {
      rows.splice(index,1);
      this.deleteCustomer(item.id)
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
                <th>Subscription</th>
                <th>Status</th>
                <th style={{width:"50px"}}>Remove</th>
              </tr>
            </thead>
            <tbody>
            {
              this.state.customers.map((item, i) => (
              <tr onClick={() => this.showDetails(item)} key={i}>
                  {this.expiryDateAndStatusUpdate(item)}
                <td>{item.id}</td>
                <td>{item.name}</td>
                <td>{item.contact}</td>
                <td>{item.s_name}</td>
                <td>{item.status}</td>
                <td><a href="#" onClick={() =>
                  {
                    if (window.confirm('Are you sure you wish to delete this item?'))
                      this.delete(i, this.state.customers,item) }
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
              <label>Address</label>
              <td><input type="text" name="address" value={this.state.address} onChange={e => this.change(e)}/></td>
              <label>Subscription Id</label>
              <td><select style={{width:"180px", height:"30px"}} name="sub" value={this.state.sub} onChange={e => this.change(e)}>
                <option>Select</option>
                {
                  this.state.services.map((item, i) => (
                  <option>{item['service']}</option>
                  ))
                }
              </select></td>
              <label>Device Id</label>
              <td><select style={{width:"180px", height:"30px"}} name="device" value={this.state.device} onChange={e => this.change(e)}>
                <option>Select</option>
                {
                  this.state.devices.map((item, i) => (
                  <option>{item['device']}</option>
                  ))
                }
              </select></td>
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
