import React, { Component } from 'react';
import { Table, Button, Modal } from 'react-bootstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

  class GeneralJournal extends Component{
    constructor(props){
      super(props);
      this.state={
        showPopup:false, debitInput:[], creditInput:[],
        d_desc: '', d_amount: '', d_type: '', c_desc: '', c_amount: '', c_type: '',
        entries:[]
      };
    }

    //-----------------------------------Database functions start-------------------------------------------------------

    componentDidMount(){
      this.getEntries();
    }

    getEntries = _ =>{
        fetch('http://localhost:4000/fa_Entry')
        .then(res => {
          return res.json()
       })
      .then(fa_Entry => {
          this.setState({ entries: fa_Entry })
       })
        .catch(err => console.error(err));
    };

    //-----------------------------------Database functions ends--------------------------------------------------------

    handleClose=()=> {
      this.setState({
        showPopup: false,
        d_desc:'', d_amount:'', d_type:'',
        c_desc:'', c_amount:'', c_type:'',
        debitInput:[],
        creditInput:[]
      });
    }

    handleShow=()=> {
      this.setState({ showPopup: true });
    }

    toggleCheckox=()=> {
      this.setState({ chkbox: !this.state.chkbox });
    }

    change = e => {
      this.setState({
        [e.target.name]: e.target.value
      });
    };

    addDebit = () =>{
      if(this.state.d_desc=='' || this.state.d_amount==0 || this.state.d_type==''){
        this.setState({ err : 'empty field!' });
      }
      else{
        var input={description:this.state.d_desc, amount:this.state.d_amount, type:this.state.d_type}
        this.state.debitInput.push(input);
        this.setState({
          d_desc:'', d_amount:'', d_type:'', err:''
        });
      }
    };

    addCredit = () =>{
      if(this.state.c_desc=='' || this.state.c_amount==0 || this.state.c_type==''){
        this.setState({ err : 'empty field!' });
      }
      else{
        var input={description:this.state.c_desc, amount:this.state.c_amount, type:this.state.c_type}
        this.state.creditInput.push(input);
        this.setState({
          c_desc:'', c_amount:'', c_type:'', err:''
        });
      }
    };

    add = states => {
    //   let row = this.state.rows;
    //   if(states.chkbox==true) states.date='Adj';
    //   let creditAmount=0, debitAmount=0;
    //   for(let i=0; i<states.debit.length; i++){
    //     debitAmount+=parseInt(states.debit[i][1]);
    //   }
    //   for(let i=0; i<states.credit.length; i++){
    //     creditAmount+=parseInt(states.credit[i][1]);
    //   }
    //   if(states.date=='' || states.debit.length==0 || states.credit.length==0){
    //     this.setState({
    //       err : 'empty field!'
    //     });
    //   }
    //   else if(debitAmount!=creditAmount){
    //     this.setState({
    //       err : 'inequal debit and credit amount!'
    //     });
    //   }
    //   else{
    //     row.push([states.date, states.debit, states.credit]);
    //     this.setState({
    //       rows : row,
    //       date : '',
    //       debit : [],
    //       credit : [],
    //       err : '',
    //       chkbox: false
    //     });
    //   }
    };

    delete = (index, rows) => {
      rows.splice(index,1);
    };

    render(){
      return(
      <div id="GJ">
        {
        //------------------------------------------display table-------------------------------------------------
        }
        <Button id="addBtn" onClick={this.handleShow}>Add</Button><br/>
        <Table bordered size="sm"  style={{textAlign:"left"}}>
          <thead style={{backgroundColor:"white", borderBottom:"3px solid #ec9841"}}>
            <tr>
              <th>Date</th>
              <th>General Journal</th>
              <th>Amount</th>
              <th>Delete</th>
            </tr>
          </thead>
          <tbody>
          {
            this.state.entries.map((item, i) => (
            <tr key={i}>
              <td>{item.t_date}</td>
              <td>{item.description}</td>
              <td>{item.amount}</td>
              <td>DELETE</td>
            </tr>
            ))
          }
          {
            // <a href="#" onClick={() => { if (window.confirm('Are you sure you wish to delete this item?')) this.delete(i, this.state.debitInput) } }>Delete</a>
          }
          </tbody>
        </Table>

        {
          //----------------------------------------add button popup--------------------------------------------------
        }
        <Modal size="lg" show={this.state.showPopup} onHide={this.handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>Add Transaction</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Table bordered size="sm">
              <thead  style={{color:"white", backgroundColor:"#ec9841"}}>
                <tr>
                  <th style={{backgroundColor:"white"}}></th>
                  <th>General Journal</th>
                  <th>Amount</th>
                  <th>Type</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
              {
                //----------------display debit fields---------------------------
              }
                {
                  this.state.debitInput.map((item, i) => (
                  <tr key={i}>
                    <td style={{color:"white", backgroundColor:"#ec9841"}}>Debit</td>
                    <td>{item.description}</td>
                    <td>{item.amount}</td>
                    <td>{item.type}</td>
                    <td><a href="#" onClick={() => { if (window.confirm('Are you sure you wish to delete this item?')) this.delete(i, this.state.debitInput) } }>Delete</a></td>
                  </tr>
                  ))
                }
                {
                  //----------------input debit fields---------------------------
                }
                <tr>
                  <td style={{color:"white", backgroundColor:"#ec9841"}}>Debit</td>
                  <td><input type="text" name="d_desc" value={this.state.d_desc} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="d_amount" value={this.state.d_amount} onChange={e => this.change(e)}/></td>
                  <select name="d_type" value={this.state.d_type} onChange={e => this.change(e)}>
                    <option>Select</option>
                    <option>Asset</option>
                    <option>Liability</option>
                    <option>Revenue</option>
                    <option>Expanse</option>
                    <option>Owner Capital</option>
                  </select>
                  <td><FontAwesomeIcon style={{color:"blue"}} onClick={()=> this.addDebit()} icon="plus" /></td>
                </tr>
                {
                  //----------------display credit fields---------------------------
                }
                {
                  this.state.creditInput.map((item, i) => (
                  <tr key={i}>
                    <td style={{color:"white", backgroundColor:"#ec9841"}}>Credit</td>
                    <td>{item.description}</td>
                    <td>{item.amount}</td>
                    <td>{item.type}</td>
                    <td><a href="#" onClick={() => { if (window.confirm('Are you sure you wish to delete this item?')) this.deleteDebit(i, this.state.creditInput) } }>Delete</a></td>
                  </tr>
                  ))
                }
                {
                  //----------------input credit fields---------------------------
                }
                <tr>
                  <td style={{color:"white", backgroundColor:"#ec9841"}}>Credit</td>
                  <td><input type="text" name="c_desc" value={this.state.c_desc} onChange={e => this.change(e)}/></td>
                  <td><input type="number" name="c_amount" value={this.state.c_amount} onChange={e => this.change(e)}/></td>
                  <select name="c_type" value={this.state.c_type} onChange={e => this.change(e)}>
                    <option>Select</option>
                    <option>Asset</option>
                    <option>Liability</option>
                    <option>Revenue</option>
                    <option>Expanse</option>
                    <option>Owner Capital</option>
                  </select>
                  <td><FontAwesomeIcon style={{color:"blue"}} onClick={()=> this.addCredit()} icon="plus" /></td>
                </tr>
              </tbody>
            </Table>
            <label>Date:</label> &nbsp;
            <input type="date" name="date" value={this.state.date} onChange={e => this.change(e)}/>
            <span style={{color:"red"}}>{this.state.err}</span>
            <input style={{float:"right", margin:"7px 25px 0 0"}} type="checkbox" checked={this.state.chkbox} onChange={this.toggleCheckox} id="adj" />
            <label style={{float:"right", marginRight:"5px"}} for="adj">Adjustment</label>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={this.handleClose}>Close</Button>
            <Button variant="primary" onClick={()=> this.add(this.state)}>Add</Button>
          </Modal.Footer>
        </Modal>

      </div>
    );
  }
}

export default GeneralJournal;
