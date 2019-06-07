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
        name:'', contact:'', address:'', sub:'', device:'', err:'', sno:1, detail: {}, customer_id:1,
        showPopup:false, showDetails:false, deviceDetails:true
      };
    }




    componentDidMount(){
      this.getCustomers();
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
        this.getCustomers();
        return res.json();
     })
    .catch(err => console.error(err));
  };

  addCustomer = customer =>
    {
      fetch('http://localhost:4000/customers/',{
        method : 'POST',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(customer)

    })
    .then(res => {
      this.getCustomers();
      return res.json();

   })
   .catch(err => console.error(err));
  };

    expiryDateAndStatusUpdate=(item)=> {

      // console.log(item);

      if (item.s_validity === null)
          alert("Sevice not purchase")

     let date = new Date(item.active_date)
      let expiryDate = "UnKnown Activation Date";

      if (item.s_validity.toLowerCase().search('month') !== -1)
           expiryDate = date.addMonths(item.s_validity.split(' ')[0]);
      else if (item.s_validity.toLowerCase().search('day') !== -1)
           expiryDate = date.addDays(item.s_validity.split(' ')[0]);

        item['exp'] = expiryDate;
      if(expiryDate >= Date.now())
          item.status = "Active";
        else
        item.status = "Deactive";

    };

    editCustomer = (customer,id) =>
    {
      console.log(customer);

      fetch('http://localhost:4000/customers/'+id,{
        method : 'PUT',
        headers: {'Content-Type':'application/json'},
        body : JSON.stringify(customer)
      })
      .then(res => {
        this.getCustomers();
        return res.json();
     })
     .catch(err => console.error(err));
    };


    handleClose=()=> {
      this.setState({
        showPopup: false ,
        name : '',
        contact : '',
        address : '',
        sub : '',
        device : '',
        err: ''
      });
    }

    handleShow=()=> {
      this.getDevices();
      this.getServices();
      this.setState({ showPopup: true });
    }

    editClose=()=> {
      this.setState({
        editPopup: false,
        name : '',
        contact : '',
        address : '',
        sub : '',
        device : '',
        err: ''
      });
    }

    editShow=()=> {
      this.getDevices();
      this.getServices();
      this.setState({ editPopup: true });
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
    return  this.state.services.find( s => s.service === name).id
    //   for(let i=0; i<this.state.services.length; i++){
    //     if(this.state.services['service']==name)
    //       return this.state.services['id'];
    //   }
    };

    findDeviceId = name => {
      return  this.state.devices.find( s => s.device === name).id

      // for(let i=0; i<this.state.devices.length; i++){
      //   if(this.state.devices['device']==name)
      //     return this.state.devices['id'];
      // }
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
        if(states.device !== null)
          states.device=this.findDeviceId(states.device);
        else states.device=null;

        var custom_customer = {
          "name": states.name,
          "contact" : states.contact,
          "address" : states.address,
          "service_id" : states.sub,
          "device_id" : states.device,
          "active_date" : (new Date()).toJSON().slice(0,10).split('-').join('/')
        }

        // row.push([states.sno++, states.name, states.contact, states.address, states.sub, states.device]);

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
        this.handleClose();
      }
    };

    edit = states => {
      if(states.name==='' || states.contact==='' || states.address==='' || states.sub==='' || states.device===''){
        this.setState({
          err : 'empty field!'
        });
      }
      else{
        states.sub=this.findServiceId(states.sub);
        if(states.device !== null)
          states.device=this.findDeviceId(states.device);
        else states.device=null;

        var custom_customer = {
          "name": states.name,
          "contact" : states.contact,
          "address" : states.address,
          "service_id" : states.sub,
          "device_id" : states.device,
        }

        this.editCustomer(custom_customer, states.customer_id);
        this.editClose();
      }
    };

    //rows: array from which element is to be deleted
    delete = (index, rows,item) => {
      rows.splice(index,1);
      this.deleteCustomer(item.id)
    };

    renewDate = item => {
      var custom_customer = {
        "active_date" : (new Date()).toJSON().slice(0,10).split('-').join('/')
      }
      this.editCustomer(custom_customer, item.id);
    };

    renew = item =>{
      if(item.status=="Deactive")
        return(<span>
          <a href="#" onClick={() =>
            {this.renewDate(item)}
            }>
            <FontAwesomeIcon className="icon" icon="arrow-alt-circle-up" style={{float:"right", color:"gray"}} /></a>
          </span>);
      return(<span></span>);
    }

    modalBody = () => {
      return(
        <div>
          <label>Contact</label>
          <td><input type="text" name="contact" value={this.state.contact} onChange={e => this.change(e)}/></td>
          <label>Address</label>
          <td><input type="text" name="address" value={this.state.address} onChange={e => this.change(e)}/></td>
          <label>Subscription</label>
          <td><select style={{width:"180px", height:"30px"}} name="sub" value={this.state.sub} onChange={e => this.change(e)}>
            <option>Select</option>
            {
              this.state.services.map((item, i) => (
              <option>{item['service']}</option>
              ))
            }
          </select></td>
          <label>Device</label>
          <td><select style={{width:"180px", height:"30px"}} name="device" value={this.state.device} onChange={e => this.change(e)}>
            <option>Select</option>
            {
              this.state.devices.map((item, i) => (
              <option>{item['device']}</option>
              ))
            }
          </select></td>
        </div>
      );
    }

    render(){
      console.log(this.state.customers);

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
              <th>Subscription</th>
              <th>Status</th>
              <th style={{width:"100px"}}>Action</th>
            </tr>
          </thead>
          <tbody>
          {

            this.state.customers.map((item, i) => (
            <tr key={i}>
                {this.expiryDateAndStatusUpdate(item)}
              <td onClick={() => this.showDetails(item)}>{i+1}</td>
              <td onClick={() => this.showDetails(item)}>{item.name}</td>
              <td onClick={() => this.showDetails(item)}>{item.contact}</td>
              <td onClick={() => this.showDetails(item)}>{item.s_name}</td>
              <td>{item.status}<span>{this.renew(item)}</span></td>
              <td>
              <a href="#" onClick={() =>
              {
                this.setState({
                  name : item.name,
                  contact : item.contact,
                  address : item.address,
                  sub : item.s_name,
                  device : item.d_name,
                  customer_id: item.id
                });
                this.editShow()
              }
              }>
              <FontAwesomeIcon className="icon" icon="edit" style={{marginLeft:"20%", color:"blue"}} /></a>
              <a href="#" onClick={() =>
                {
                  if (window.confirm('Are you sure you wish to delete this item?'))
                    this.delete(i, this.state.customers,item) }
                }>
                <FontAwesomeIcon className="icon" icon="trash" style={{marginLeft:"20%", color:"red"}} /></a>
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
            <div><span>Address : </span>{this.state.detail['address']}</div>
            <div><span>Status : </span>{this.state.detail['status']}</div>
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
            {this.modalBody()}
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
            <Modal.Title>Edit Customer</Modal.Title>
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

export default Customers;
